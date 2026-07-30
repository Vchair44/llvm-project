//===-- LCM.cpp - Lazy Code Motion ----------------------------------------===//
//
// Partial Redundancy Elimination via Lazy Code Motion
// CS 526 — Advanced Compiler Construction
//
// Implements the four-pass LCM framework (Knoop, Ruthing, Steffen, PLDI '92)
// with Briggs-Cooper improvements (PLDI '94):
//   - Critical edge splitting
//   - Global reassociation (handled upstream by ReassociatePass)
//   - Value numbering via GVNExpression
//   - Candidate expression enumeration
//   - Four dataflow passes: Anticipability, Availability, Earliest, Lateness
//   - Code insertion and deletion
//
//===----------------------------------------------------------------------===//

#include "llvm/Transforms/Scalar/LCM.h"
#include <algorithm>
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Dominators.h"          // DominatorTree
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"        // BinaryOperator, CmpInst, etc.
#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/Support/Allocator.h"      // BumpPtrAllocator
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"  // SplitAllCriticalEdges
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/IR/Module.h"

using namespace llvm;

#define DEBUG_TYPE "lcm"

//===----------------------------------------------------------------------===//
// Data Structures
//===----------------------------------------------------------------------===//

// Represents a candidate expression for LCM optimization.
// Each entry corresponds to one bit position in the bitvectors.
struct LCMExpression {
  uint32_t ValueNumber;                  // canonical ID
  unsigned Opcode;                       // e.g. Instruction::Add
  Type *ResultType;                      // return type of expr
  unsigned Predicate = 0;                // Only used for CmpInst; e.g. eq, slt, 
  SmallVector<uint32_t, 2> OpVNs;        // value numbers of operands
  Instruction *Representative = nullptr; // one concrete instruction for this expr
  
  bool operator==(const LCMExpression &Other) const {
    return Opcode == Other.Opcode
      && OpVNs == Other.OpVNs
      && ResultType == Other.ResultType
      && Predicate == Other.Predicate;
  }
};

template <> struct llvm::DenseMapInfo<LCMExpression> {
    static LCMExpression getEmptyKey() {
      LCMExpression E;
      E.ValueNumber = ~0u;
      E.Opcode = ~0u;
      E.ResultType = nullptr;
      E.Representative = nullptr;
      return E;
    }
    static LCMExpression getTombstoneKey() {
      LCMExpression E;
      E.ValueNumber = ~1u;
      E.Opcode = ~1u;
      E.ResultType = nullptr;
      E.Representative = nullptr;
      return E;
    }
    static unsigned getHashValue(const LCMExpression &E) {
        return llvm::hash_combine(
            E.Opcode,
            E.ResultType,
	    E.Predicate,
            llvm::hash_combine_range(E.OpVNs.begin(), E.OpVNs.end()));
    }
    static bool isEqual(const LCMExpression &A, const LCMExpression &B) {
        return A == B;
    }
};

// Per-basic-block bitvector sets for all five LCM dataflow equations.
struct BlockInfo {
  BitVector ANTLOC;   // locally anticipable: expr used in block before any kill
  BitVector TRANSP;   // transparent: no operand of expr killed in block
  BitVector ANTIN;    // anticipated at block entry  (backward meet)
  BitVector ANTOUT;   // anticipated at block exit   (backward meet)
  BitVector AVIN;     // available at block entry    (forward meet)
  BitVector AVOUT;    // available at block exit     (forward meet)
  BitVector EARLIEST; // derived: ~AVIN & ANTIN (no earlier legal point)
  BitVector DELAY;    // forward: earliest point not yet used
  BitVector LATEST;   // derived: DELAY & (ANTLOC | ~(AND of succ DELAY))
  BitVector ISOLATED; // backward: inserted value never reused downstream
  BitVector INSERT;   // final: LATEST & ~ISOLATED  — insert h := t here
  BitVector REPLACE;  // final: ANTLOC & (AVIN | EARLIEST) — replace t with h
};



//===----------------------------------------------------------------------===//
// Step 1 — Critical Edge Splitting
//===----------------------------------------------------------------------===//

static bool splitCriticalEdges(Function &F, DominatorTree &DT, LoopInfo &LI) {
  CriticalEdgeSplittingOptions Opts(&DT, &LI);
  return SplitAllCriticalEdges(F, Opts);
}

//===----------------------------------------------------------------------===//
// Step 2 — Value Numbering and Candidate Expression Enumeration
//
// TODO: Replace this stub with GVNExpression-based value numbering.
// Reference: llvm/include/llvm/Transforms/Scalar/GVNExpression.h
//            llvm/lib/Transforms/Scalar/NewGVN.cpp
//
// The output of this step is:
//   ValueNumbers  — maps each Value* to a uint32_t value number
//   Expressions   — indexed list of unique candidate expressions;
//                   index i corresponds to bit i in all bitvectors
//===- ---------------------------------------------------------------------===//

static void computeValueNumbers(
    Function &F,
    DenseMap<Value *, uint32_t> &ValueNumbers,
    DenseMap<uint32_t, Value*> &VNToValue,
    SmallVector<LCMExpression, 64> &Expressions) {

  // TODO: Walk all instructions and assign value numbers via GVNExpression.
  // For now this is a stub — fill in with GVNExpression infrastructure.

  DenseMap<LCMExpression, uint32_t> ExprToVN;
  BumpPtrAllocator ExprAllocator;
  uint32_t NextVN = 0;
  
  ReversePostOrderTraversal<Function*> RPOT(&F);
  for (BasicBlock *BB : RPOT) {
    for (Instruction &I : *BB) {
      // Skip instructions that are never candidates for code motion:
      //   - phi nodes (join point artifacts, not real computations)
      //   - instructions with side effects (loads, stores, calls)
      //   - terminators
      //   - instructions that produce no value (void type)
      if (isa<PHINode>(I)) {
	if (!ValueNumbers.count(&I)) { // needs to be tracked for Transp
	  uint32_t VN = NextVN++;
	  ValueNumbers[&I] = VN;
	  VNToValue[VN] = &I;
	  LLVM_DEBUG(dbgs() << "[LCM] PHI  : " << I << " -> VN " << VN << "\n");
	}
	continue; // still not a candidate expression
      }
      if (I.mayHaveSideEffects()) continue;
      if (I.isTerminator())       continue;
      if (I.getType()->isVoidTy()) continue;
      if (I.mayReadFromMemory())   continue;
      if (!isa<BinaryOperator>(I) && !isa<CmpInst>(I)) continue;
      if (I.getOpcode() == Instruction::SDiv ||
	  I.getOpcode() == Instruction::UDiv ||
	  I.getOpcode() == Instruction::SRem ||
	  I.getOpcode() == Instruction::URem) continue;
      
      LCMExpression Expr;
      Expr.Opcode = I.getOpcode();
      Expr.ResultType = I.getType();
      if (auto *Cmp = dyn_cast<CmpInst>(&I))
	Expr.Predicate = Cmp->getPredicate();
      
      for (Use &U : I.operands()) {
	Value *Op = U.get();
	if (!ValueNumbers.count(Op)) {
	  uint32_t OpVN = NextVN++;
	  ValueNumbers[Op] = OpVN;
	  VNToValue[OpVN] = Op;
	}
	Expr.OpVNs.push_back(ValueNumbers[Op]);
      }

      if (I.isCommutative() && Expr.OpVNs.size() == 2) {
	if (Expr.OpVNs[0] > Expr.OpVNs[1])
	  std::swap(Expr.OpVNs[0], Expr.OpVNs[1]);
      }
      
      auto It = ExprToVN.find(Expr);
      if (It != ExprToVN.end()){
	ValueNumbers[&I] = It->second;
	VNToValue[It->second] = &I;
	LLVM_DEBUG(dbgs() << "[LCM] REUSE: " << I << " -> VN " << It->second << "\n");
      } else {
	uint32_t VN = NextVN++;
	ValueNumbers[&I] = VN;
	VNToValue[VN] = &I;
	Expr.ValueNumber = VN;
	Expr.Representative = &I;
	ExprToVN[Expr] = VN;
	Expressions.push_back(Expr);
	LLVM_DEBUG(dbgs() << "[LCM] NEW  : " << I << " -> VN " << VN << "\n");
      }
    }
  }

  LLVM_DEBUG(dbgs() << "[LCM] Found " << Expressions.size()
                    << " candidate expressions\n");
}

//===----------------------------------------------------------------------===//
// Step 3 — Compute ANTLOC and TRANSP per BasicBlock
//
// ANTLOC(b, e): expression e is computed in b before any operand of e is
//               killed — i.e. there is a downward-exposed use of e in b.
// TRANSP(b, e): no operand of e is defined in b (block is transparent to e).
//
// Both are local properties derived from a single pass over each block.
//===----------------------------------------------------------------------===//

static void printBitvector(const BitVector &BV, unsigned NumExprs) {
    for (unsigned i = 0; i < NumExprs; ++i)
        dbgs() << (BV.test(i) ? "1" : "0");
}

static void computeLocalSets(
    Function &F,
    const SmallVector<LCMExpression, 64> &Expressions,
    const DenseMap<Value *, uint32_t> &ValueNumbers,
    DenseMap<BasicBlock *, BlockInfo> &BlockData) {

  unsigned NumExprs = Expressions.size();

  DenseMap<uint32_t, unsigned> VNToExprIndex;
  for (unsigned i = 0; i < Expressions.size(); ++i)
    VNToExprIndex[Expressions[i].ValueNumber] = i;
  
  for (BasicBlock &BB : F) {
    BlockInfo &Info = BlockData[&BB];
    Info.ANTLOC.resize(NumExprs, false);
    Info.TRANSP.resize(NumExprs, true);   // transparent until proven otherwise
    Info.ANTIN.resize(NumExprs, true);
    Info.ANTOUT.resize(NumExprs, true);
    Info.AVIN.resize(NumExprs, false);
    Info.AVOUT.resize(NumExprs, false);
    Info.EARLIEST.resize(NumExprs, false);
    Info.DELAY.resize(NumExprs, false);
    Info.LATEST.resize(NumExprs, false);
    Info.ISOLATED.resize(NumExprs, false);
    Info.INSERT.resize(NumExprs, false);
    Info.REPLACE.resize(NumExprs, false);

    // TODO: Walk instructions in BB to set ANTLOC and TRANSP.
    // For each instruction I:
    //   - If I is the representative of expression e and no operand of e
    //     has been killed earlier in this block, set ANTLOC[e].
    //   - If I defines a variable that is an operand of expression e,
    //     clear TRANSP[e].

    //ANTLOC loop
    for (Instruction &I : BB) {
      auto It = ValueNumbers.find(&I);
      if (It == ValueNumbers.end())
	continue;
      
      uint32_t VN = It->second;
      
      auto IdxIt = VNToExprIndex.find(VN);
      if (IdxIt == VNToExprIndex.end())
	continue;
      
      unsigned ExprIdx = IdxIt->second;
      Info.ANTLOC.set(ExprIdx);
      
    }

    //TRANSP loop
    for (Instruction &I : BB) {
      if (auto *Phi = dyn_cast<PHINode>(&I)) {
	// A PHI produces a new VN at this join point.
	// Any expression that uses this VN as an operand
	// is not transparent through this block.
	auto It = ValueNumbers.find(Phi);
	if (It != ValueNumbers.end()) {
	  uint32_t VN = It->second;
	  for (unsigned i = 0; i < Expressions.size(); ++i)
            for (uint32_t OpVN : Expressions[i].OpVNs)
	      if (OpVN == VN)
		Info.TRANSP.reset(i);
	}
	continue;
      }
      
      auto It = ValueNumbers.find(&I);
      if (It == ValueNumbers.end()) continue;
      uint32_t VN = It->second;
      
      for (unsigned i = 0; i < Expressions.size(); ++i) {
        for (uint32_t OpVN : Expressions[i].OpVNs) {
	  if (OpVN == VN) {
	    Info.TRANSP.reset(i);
	  }
        }
      }
    }
  }
  LLVM_DEBUG(
	     for (BasicBlock &BB : F) {
	       dbgs() << "[LCM] Block: " << BB.getName() << "\n";
	       dbgs() << "[LCM]   ANTLOC: ";
	       printBitvector(BlockData[&BB].ANTLOC, NumExprs);
	       dbgs() << "\n";
	       dbgs() << "[LCM]   TRANSP: ";
	       printBitvector(BlockData[&BB].TRANSP, NumExprs);
	       dbgs() << "\n";
	     }
	     );
}

//===----------------------------------------------------------------------===//
// Step 4 — Anticipability (Backward Dataflow)
//
// ANTOUT(b) = AND over all successors s of ANTIN(s)
// ANTIN(b)  = ANTLOC(b) | (TRANSP(b) & ANTOUT(b))
//
// Initialize ANTOUT = all-ones (top of the AND lattice).
// Iterate until convergence using reverse postorder traversal.
//===----------------------------------------------------------------------===//

static void computeAnticipability(
				  Function &F,
				  DenseMap<BasicBlock *, BlockInfo> &BlockData,
				  unsigned NumExprs) {

  // TODO: Implement backward dataflow over the CFG.
  // Drive iteration using ReversePostOrderTraversal<Function*> reversed,
  // or simply iterate over basic blocks in reverse postorder until no
  // bitvector changes.
  //
  // Pseudocode:
  //   repeat until no change:
  //     for each block b in reverse postorder (backward):
  //       ANTOUT[b] = AND of ANTIN[s] for all successors s
  //       ANTIN[b]  = ANTLOC[b] | (TRANSP[b] & ANTOUT[b])

  bool Changed = true;
  while (Changed) {
    Changed = false;
    for (BasicBlock *BB : post_order(&F)) {
      BlockInfo &Info = BlockData[BB];
      
      // ANTOUT[b] = AND of ANTIN[s] for all successors s
      BitVector NewANTOUT(NumExprs, true); // initialize to all-ones for AND
      for (BasicBlock *Succ : successors(BB)) {
	NewANTOUT &= BlockData[Succ].ANTIN;
      }

      if (succ_empty(BB)) NewANTOUT.reset(); // nothing is anticipated past exit

      // ANTIN[b] = ANTLOC[b] | (TRANSP[b] & ANTOUT[b])
      BitVector NewANTIN = Info.TRANSP;
      NewANTIN &= NewANTOUT;
      NewANTIN |= Info.ANTLOC;
      
      // Check if anything changed
      if (NewANTOUT != Info.ANTOUT || NewANTIN != Info.ANTIN) {
	Changed = true;
	Info.ANTOUT = NewANTOUT;
	Info.ANTIN = NewANTIN;
      }
    }
  }
  LLVM_DEBUG(
	     dbgs() << "[LCM] --- Anticipability ---\n";
	     for (BasicBlock &BB : F) {
	       dbgs() << "[LCM] Block: " << BB.getName() << "\n";
	       dbgs() << "[LCM]   ANTOUT: "; printBitvector(BlockData[&BB].ANTOUT, NumExprs); dbgs() << "\n";
	       dbgs() << "[LCM]   ANTIN:  "; printBitvector(BlockData[&BB].ANTIN,  NumExprs); dbgs() << "\n";
	     }
	     );
}

//===----------------------------------------------------------------------===//
// Step 5 — Availability (Forward Dataflow)
//
// AVIN(b)  = AND over all predecessors p of AVOUT(p)
// AVOUT(b) = ANTLOC(b) | (TRANSP(b) & AVIN(b))  [actually: used-or-computed]
//
// Initialize AVIN of entry = all-zeros.
// Iterate until convergence in postorder.
//===----------------------------------------------------------------------===//

static void computeAvailability(
				Function &F,
				DenseMap<BasicBlock *, BlockInfo> &BlockData,
				unsigned NumExprs) {

  // TODO: Implement forward dataflow over the CFG.
  //
  // Pseudocode:
  //   repeat until no change:
  //     for each block b in postorder:
  //       AVIN[b]  = AND of AVOUT[p] for all predecessors p
  //       AVOUT[b] = ANTLOC[b] | (TRANSP[b] & AVIN[b])
  bool Changed = true;
  ReversePostOrderTraversal<Function*> RPOT(&F);
  while (Changed) {
    Changed = false;
    for (BasicBlock *BB : RPOT) {
      BlockInfo &Info = BlockData[BB];
      BitVector NewAVIN(NumExprs, true);
      if (pred_empty(BB)) NewAVIN.reset();
      else {
	for (BasicBlock *Pred : predecessors(BB)) {
	  NewAVIN &= BlockData[Pred].AVOUT;
	}
      }

      BitVector NewAVOUT = Info.TRANSP;
      NewAVOUT &= NewAVIN;
      NewAVOUT |= Info.ANTLOC;

      if (NewAVOUT != Info.AVOUT || NewAVIN != Info.AVIN) {
	Changed = true;
	Info.AVOUT = NewAVOUT;
	Info.AVIN = NewAVIN;
      }
    }
  }
  LLVM_DEBUG(
	     dbgs() << "[LCM] --- Availability ---\n";
	     for (BasicBlock &BB : F) {
	       dbgs() << "[LCM] Block: " << BB.getName() << "\n";
	       dbgs() << "[LCM]   AVIN:  "; printBitvector(BlockData[&BB].AVIN,  NumExprs); dbgs() << "\n";
	       dbgs() << "[LCM]   AVOUT: "; printBitvector(BlockData[&BB].AVOUT, NumExprs); dbgs() << "\n";
	     }
	     );
}

//===----------------------------------------------------------------------===//
// Step 6 — Earliest Placement (Algebraic Derivation)
//
// EARLIEST(b) = ANTIN(b) & ~AVIN(b)
//
// An expression is earliest at b if it is anticipated (safe to insert)
// but not yet available (hasn't been computed on all paths to b).
// No additional traversal needed — derived directly from steps 4 and 5.
//===----------------------------------------------------------------------===//

static void computeEarliest(
			    Function &F,
			    DenseMap<BasicBlock *, BlockInfo> &BlockData,
			    unsigned NumExprs) {

  for (BasicBlock &BB : F) {
    BlockInfo &Info = BlockData[&BB];
    // EARLIEST = ANTIN & ~AVIN
    Info.EARLIEST = Info.ANTIN;
    Info.EARLIEST.reset(Info.AVIN); // bitwise AND with complement
  }
  LLVM_DEBUG(
	     dbgs() << "[LCM] --- Earliest ---\n";
	     for (BasicBlock &BB : F) {
	       dbgs() << "[LCM] Block: " << BB.getName() << "\n";
	       dbgs() << "[LCM]   EARLIEST: ";
	       printBitvector(BlockData[&BB].EARLIEST, BlockData[&BB].EARLIEST.size());
	       dbgs() << "\n";
	     }
	     );
}

//===----------------------------------------------------------------------===//
// Step 7 — Lateness / Laziness (Forward Dataflow)
//
// DELAY(b):  expression can be delayed to b — it has been earliest somewhere
//            upstream and has not been used (ANTLOC) since.
// LATEST(b): last valid point to insert — DELAY(b) & (ANTLOC(b) | not all
//            successors are DELAY).
//
// Validated against DominatorTree to ensure insertion points remain legal.
//===----------------------------------------------------------------------===//

static void computeLateness(
			    Function &F,
			    DominatorTree &DT,
			    DenseMap<BasicBlock *, BlockInfo> &BlockData,
			    unsigned NumExprs) {

  // TODO: Implement forward DELAY pass, then derive LATEST algebraically.
  //
  // DELAY forward dataflow:
  //   DELAY_IN(entry) = EARLIEST(entry)
  //   DELAY_IN(b)     = AND of DELAY_OUT(p) for all predecessors p
  //   DELAY_OUT(b)    = (EARLIEST(b) | DELAY_IN(b)) & ~ANTLOC(b)
  //
  // Then:
  //   LATEST(b) = (EARLIEST(b) | DELAY_IN(b)) &
  //               (ANTLOC(b) | ~(AND of DELAY_IN(s) for all successors s))

  DenseMap<BasicBlock *, BitVector> DelayIn;
  for (BasicBlock &BB : F)
    DelayIn[&BB] = BitVector(NumExprs, true);

  ReversePostOrderTraversal<Function *> RPOT(&F);
  bool Changed = true;
  while (Changed) {
    Changed = false;
    for (BasicBlock *BB : RPOT) {
      BlockInfo &Info = BlockData[BB];

      // Compute and store DELAY_IN
      BitVector NewDelayIn(NumExprs, true);
      if (pred_empty(BB))
        NewDelayIn = Info.EARLIEST;
      else
        for (BasicBlock *Pred : predecessors(BB))
          NewDelayIn &= BlockData[Pred].DELAY;
      DelayIn[BB] = NewDelayIn;

      // DELAY_OUT = (EARLIEST | DELAY_IN) & ~ANTLOC
      BitVector NewDelay = Info.EARLIEST;
      NewDelay |= NewDelayIn;
      NewDelay.reset(Info.ANTLOC);

      if (NewDelay != Info.DELAY || NewDelayIn != DelayIn[BB]) {
        Changed = true;
        Info.DELAY = NewDelay;
	DelayIn[BB] = NewDelayIn;
      }
    }
  }

  // --- Derive LATEST using stored DELAY_IN ---
  for (BasicBlock &BB : F) {
    BlockInfo &Info = BlockData[&BB];

    BitVector SuccDelayInAnd(NumExprs, true);
    if (succ_empty(&BB))
      SuccDelayInAnd.reset();
    else
      for (BasicBlock *Succ : successors(&BB))
        SuccDelayInAnd &= DelayIn[Succ];

    BitVector Latest = Info.EARLIEST;
    Latest |= DelayIn[&BB];

    BitVector Temp = SuccDelayInAnd;
    Temp.flip();
    Temp |= Info.ANTLOC;

    Latest &= Temp;
    Info.LATEST = Latest;
  }

  
  LLVM_DEBUG(
	     dbgs() << "[LCM] --- Delay ---\n";
	     for (BasicBlock &BB : F) {
	       dbgs() << "[LCM] Block: " << BB.getName() << "\n";
	       dbgs() << "[LCM]   DELAY: ";
	       printBitvector(BlockData[&BB].DELAY, NumExprs);
	       dbgs() << "\n";
	     }
	     dbgs() << "[LCM] --- Latest ---\n";
	     for (BasicBlock &BB : F) {
	       dbgs() << "[LCM] Block: " << BB.getName() << "\n";
	       dbgs() << "[LCM]   LATEST: ";
	       printBitvector(BlockData[&BB].LATEST, NumExprs);
	       dbgs() << "\n";
	     }
	     );
}

//===----------------------------------------------------------------------===//
// Step 8 — Isolated (Backward Dataflow)
//
// ISOLATED(b): all successors of b will re-insert the expression before
//              any original use — so inserting at b provides no benefit.
//
// ISOLATED_OUT(b) = AND of (LATEST(s) | ISOLATED_IN(s)) for all successors s
// ISOLATED_IN(b)  = ~ANTLOC(b) & (LATEST(b) | ISOLATED_OUT(b))
//===----------------------------------------------------------------------===//

static void computeIsolated(
			    Function &F,
			    DenseMap<BasicBlock *, BlockInfo> &BlockData,
			    unsigned NumExprs) {

  // TODO: Implement backward ISOLATED dataflow.
  // Then derive final insertion and replacement sets:
  //   INSERT[b]  = LATEST[b] & ~ISOLATED[b]
  //   REPLACE[b] = ANTLOC[b] & ~(EARLIEST[b] & ~ISOLATED[b])
  bool Changed = true;
  while (Changed) {
    Changed = false;
    for (BasicBlock *BB : post_order(&F)) {
      BlockInfo &Info = BlockData[BB];

      BitVector IsolatedOut(NumExprs, true); // initialize to all-ones for AND
      if (succ_empty(BB)) IsolatedOut.reset(); // nothing is anticipated past exit
      else {
	for (BasicBlock *Succ : successors(BB)) {
	  BitVector temp = BlockData[Succ].LATEST;
	  temp.reset(BlockData[Succ].ANTLOC);
	  temp |= BlockData[Succ].ISOLATED;
	  IsolatedOut &= temp;
	}
      }

      BitVector IsolatedIn = IsolatedOut;
      IsolatedIn.reset(Info.ANTLOC);

      if(IsolatedIn != Info.ISOLATED){
	Changed = true;
	Info.ISOLATED = IsolatedIn;
      }
    }
  }
  
  for (BasicBlock &BB : F) {
    BlockInfo &Info = BlockData[&BB];

    // INSERT = LATEST & ~ISOLATED
    Info.INSERT = Info.LATEST;
    Info.INSERT.reset(Info.ISOLATED);
    
    // REPLACE = ANTLOC & ~(INSERT)
    Info.REPLACE = Info.ANTLOC;
    Info.REPLACE.reset(Info.INSERT);
  }

  LLVM_DEBUG(
	     dbgs() << "[LCM] --- Isolated / Insert / Replace ---\n";
	     for (BasicBlock &BB : F) {
	       dbgs() << "[LCM] Block: " << BB.getName() << "\n";
	       dbgs() << "[LCM]   ISOLATED: "; printBitvector(BlockData[&BB].ISOLATED, NumExprs); dbgs() << "\n";
	       dbgs() << "[LCM]   INSERT:   "; printBitvector(BlockData[&BB].INSERT,   NumExprs); dbgs() << "\n";
	       dbgs() << "[LCM]   REPLACE:  "; printBitvector(BlockData[&BB].REPLACE,  NumExprs); dbgs() << "\n";
	     }
	     );
}

//===----------------------------------------------------------------------===//
// Step 9 — Code Insertion and Deletion
//
// For each expression e and each block b where INSERT[b][e] is set:
//   - Create a new temporary h via IRBuilder at the start of b
//   - For each block b where REPLACE[b][e] is set:
//     - Replace the original computation of e with a use of h
//     - via replaceAllUsesWith on the original Instruction
//===----------------------------------------------------------------------===//


static void insertAndReplace(
    Function &F,
    const SmallVector<LCMExpression, 64> &Expressions,
    DenseMap<BasicBlock *, BlockInfo> &BlockData,
    const DenseMap<Value *, uint32_t> &ValueNumbers,
    const DenseMap<uint32_t, Value *> &VNToValue,
    DominatorTree &DT,
    unsigned NumExprs) {
 
  // Maps (BB, ExprIdx) -> the Value* available at BB's exit for that expression.
  // Populated by Phase 1 (INSERT) and Phase 1b (PHI insertion at REPLACE sites).
  DenseMap<std::pair<BasicBlock*, unsigned>, Value*> AvailAtExit;
 
  // Returns the Value* carrying expression i at the exit of Pred, or nullptr.
  // Checks AvailAtExit first (inserted temps / PHIs), then scans Pred's
  // instructions for an original computation with the matching VN.
  auto getAvailableValueAtExit = [&](BasicBlock *Pred,
                                     unsigned i) -> Value* {
    // Direct hit
    auto It = AvailAtExit.find({Pred, i});
    if (It != AvailAtExit.end()) return It->second;
    
    // Scan Pred's own instructions
    const LCMExpression &Expr = Expressions[i];
    for (Instruction &I : *Pred) {
      auto VNIt = ValueNumbers.find(&I);
      if (VNIt != ValueNumbers.end() && VNIt->second == Expr.ValueNumber)
	return &I;
    }
    
    // Walk dominator tree upward — value may be available from a dominator
    DomTreeNode *Node = DT.getNode(Pred);
    if (Node) Node = Node->getIDom();
    while (Node) {
      BasicBlock *DomBB = Node->getBlock();
      auto DomIt = AvailAtExit.find({DomBB, i});
      if (DomIt != AvailAtExit.end()) return DomIt->second;
      for (Instruction &I : *DomBB) {
      auto VNIt = ValueNumbers.find(&I);
      if (VNIt != ValueNumbers.end() && VNIt->second == Expr.ValueNumber)
        return &I;
      }
      Node = Node->getIDom();
    }
    return nullptr;
  };
  
  ReversePostOrderTraversal<Function *> RPOT(&F);
 
  // ---- Phase 1: INSERT ----
  // Process in RPOT so dominating INSERT blocks are handled before dominated
  // REPLACE blocks, ensuring AvailAtExit is populated in dependency order.
  for (BasicBlock *BB : RPOT) {
    BlockInfo &Info = BlockData[BB];

    BasicBlock::iterator InsertPt;
    if (BB->isEHPad()) InsertPt = BB->getFirstNonPHIOrDbgOrAlloca();
    else InsertPt = BB->getTerminator()->getIterator(); 

    for (unsigned i = 0; i < NumExprs; i++) {
      if (!Info.INSERT.test(i)) continue;
 
      const LCMExpression &Expr = Expressions[i];
 
      // INSERT+REPLACE same block: original stays. Only record if a pure
      // INSERT (ANTLOC=0) hasn't already claimed this slot — pure INSERT
      // blocks dominate REPLACE sites and must win.
      if (Info.ANTLOC.test(i)) {
        if (!AvailAtExit.count({BB, i})) {
          for (Instruction &I : *BB) {
            auto VNIt = ValueNumbers.find(&I);
            if (VNIt != ValueNumbers.end() && VNIt->second == Expr.ValueNumber) {
              AvailAtExit[{BB, i}] = &I;
              LLVM_DEBUG(dbgs() << "[LCM] INSERT+REPLACE (keep) expr " << i
                                << " in " << BB->getName() << ": " << I << "\n");
              break;
            }
          }
        }
        continue;
      }
 
      // Pure INSERT block (ANTLOC=0): clone and insert before first non-PHI.
      // Resolve operands — check AvailAtExit first for nested exprs,
      // then fall back to VNToValue for args/constants.
      SmallVector<Value *, 2> Operands;
      bool OperandsValid = true;
 
      for (uint32_t OpVN : Expr.OpVNs) {
        Value *OpVal = nullptr;
 
        for (unsigned j = 0; j < i; j++) {
          if (j < Expressions.size() && Expressions[j].ValueNumber == OpVN) {
            auto InsIt = AvailAtExit.find({BB, j});
            if (InsIt != AvailAtExit.end()) {
              OpVal = InsIt->second;
              break;
            }
          }
        }
 
        if (!OpVal) {
          auto VNIt = VNToValue.find(OpVN);
          if (VNIt == VNToValue.end()) { OperandsValid = false; break; }
          OpVal = VNIt->second;
        }
 
        // Verify instruction operands dominate the insertion block.
        if (auto *OpInst = dyn_cast<Instruction>(OpVal)) {
          if (!DT.dominates(OpInst->getParent(), BB)) {
            OperandsValid = false; break;
          }
        }
 
        Operands.push_back(OpVal);
      }
 
      if (!OperandsValid) continue;

      assert(Expr.Representative && !Expr.Representative->getParent()->empty() &&
	     "LCM: Representative instruction has been invalidated");
      Instruction *NewInst = Expr.Representative->clone();

      for (unsigned j = 0; j < Operands.size(); j++) NewInst->setOperand(j, Operands[j]);

      NewInst->setName("lcm.tmp");
      NewInst->insertBefore(*BB, InsertPt);
      AvailAtExit[{BB, i}] = NewInst;
      LLVM_DEBUG(dbgs() << "[LCM] INSERT expr " << i
                        << " in " << BB->getName() << ": " << *NewInst << "\n");
    }
  }
 
  // ---- Phase 2: REPLACE with PHI insertion ----
  // For each REPLACE block, check each incoming edge for the available Value*.
  // If all edges carry the same Value*, use it directly.
  // If edges carry different Values*, insert a PHI to merge them.
  // This handles the partial redundancy case where a pure INSERT on one path
  // and an original computation on another path need to be unified.
  LLVM_DEBUG(dbgs() << "[LCM] --- REPLACE candidates ---\n";
             for (BasicBlock *BB : RPOT) {
               BlockInfo &Info = BlockData[BB];
               for (unsigned i = 0; i < NumExprs; i++) {
                 if (!Info.REPLACE.test(i)) continue;
                 dbgs() << "[LCM]   expr " << i
                        << " in block " << BB->getName()
                        << " INSERT=" << Info.INSERT.test(i) << "\n";
               }
             });
 
  for (BasicBlock *BB : RPOT) {
    BlockInfo &Info = BlockData[BB];
    SmallVector<Instruction *, 8> ToErase;
 
    for (unsigned i = 0; i < NumExprs; i++) {
      if (!Info.REPLACE.test(i) && !Info.ANTLOC.test(i)) continue;
      if (pred_empty(BB)) continue;
      
      const LCMExpression &Expr = Expressions[i];
      
      // Gather the Value* available on each incoming edge.
      SmallVector<std::pair<BasicBlock*, Value*>, 4> IncomingVals;
      bool AllAvailable = true;
 
      for (BasicBlock *Pred : predecessors(BB)) {
        Value *V = getAvailableValueAtExit(Pred, i);
        IncomingVals.push_back({Pred, V});
        if (!V) AllAvailable = false;
      }
 
      if (IncomingVals.empty() || !AllAvailable) {
        LLVM_DEBUG(dbgs() << "[LCM] REPLACE expr " << i << " in "
                          << BB->getName()
                          << ": SKIP — value not available on all edges\n");
        continue;
      }
 
      // Check if all incoming values are the same Value* — no PHI needed.
      Value *UniqueVal = IncomingVals[0].second;
      bool NeedsPHI = false;
      for (auto &[Pred, V] : IncomingVals) {
        if (V != UniqueVal) { NeedsPHI = true; break; }
      }
 
      Value *Replacement = nullptr;
 
      if (NeedsPHI) {
        // Insert a PHI at the top of BB to merge incoming values.
        IRBuilder<> Builder(BB, BB->getFirstNonPHIIt());
	assert(Expr.ResultType && "LCM: expression has null ResultType");
        PHINode *PHI = Builder.CreatePHI(Expr.ResultType,
                                          IncomingVals.size(), "lcm.phi");
        for (auto &[Pred, V] : IncomingVals)
          PHI->addIncoming(V, Pred);
        Replacement = PHI;
        AvailAtExit[{BB, i}] = PHI;
	LLVM_DEBUG(dbgs() << "[LCM] PHI expr " << i << " in "
                          << BB->getName() << ": " << *PHI << "\n");
      } else {
        Replacement = UniqueVal;
        AvailAtExit[{BB, i}] = UniqueVal;
      }
 
      // Find and replace the original instruction in this block.
      Instruction *OrigInst = nullptr;
      for (Instruction &I : *BB) {
        auto VNIt = ValueNumbers.find(&I);
        if (VNIt != ValueNumbers.end() && VNIt->second == Expr.ValueNumber) {
          OrigInst = &I;
          break;
        }
      }
 
      if (!OrigInst || Replacement == OrigInst) continue;
 
      LLVM_DEBUG(dbgs() << "[LCM] REPLACE expr " << i << " in "
                        << BB->getName() << ": " << *OrigInst
                        << "  ->  " << *Replacement << "\n");
 
      OrigInst->replaceAllUsesWith(Replacement);
      ToErase.push_back(OrigInst);
    }
 
    for (Instruction *I : ToErase){
      I->eraseFromParent();
    }
  }
}

static bool simplifyInsertedPHIs(Function &F) {
  bool Changed = false;
  SmallVector<PHINode*, 16> ToErase;

  for (BasicBlock &BB : F) {
    for (Instruction &I : BB) {
      auto *PHI = dyn_cast<PHINode>(&I);
      if (!PHI || !PHI->getName().starts_with("lcm.phi")) continue;

      // Check if all incoming values are the same
      Value *UniqueVal = PHI->getIncomingValue(0);
      bool AllSame = true;
      for (unsigned i = 1; i < PHI->getNumIncomingValues(); i++) {
        if (PHI->getIncomingValue(i) != UniqueVal) { AllSame = false; break; }
      }

      if (AllSame) {
        PHI->replaceAllUsesWith(UniqueVal);
        ToErase.push_back(PHI);
        Changed = true;
      }
    }
  }

  for (PHINode *PHI : ToErase)
    PHI->eraseFromParent();

  return Changed;
}


static bool simplifyInsertedInstructions(Function &F,
                                          const DataLayout &DL,
                                          const TargetLibraryInfo *TLI,
                                          DominatorTree &DT) {
  bool Changed = false;
  SmallVector<Instruction*, 16> ToErase;

  for (BasicBlock &BB : F) {
    for (Instruction &I : BB) {
      if (!I.getName().starts_with("lcm.tmp")) continue;

      // Try to simplify using LLVM's existing machinery
      SimplifyQuery SQ(DL, TLI, &DT);
      if (Value *V = simplifyInstruction(&I, SQ)) {
        I.replaceAllUsesWith(V);
        ToErase.push_back(&I);
        Changed = true;
      }
    }
  }

  for (Instruction *I : ToErase)
    I->eraseFromParent();

  return Changed;
}

static bool removeDeadLCMInserts(Function &F) {
  bool Changed = false;
  bool LocalChanged = true;

  // Iterate to a fixed point: removing one dead lcm.tmp can make an
  // instruction it depended on dead too (e.g. lcm.tmp30 = mul lcm.tmp27, lcm.tmp28 —
  // removing lcm.tmp30 doesn't free lcm.tmp27/28 if they're still used elsewhere,
  // but in deeper chains a single pass can miss newly-dead instructions).
  while (LocalChanged) {
    LocalChanged = false;
    SmallVector<Instruction*, 16> ToErase;

    for (BasicBlock &BB : F) {
      for (Instruction &I : BB) {
        if (!I.getName().starts_with("lcm.tmp")) continue;
        if (!I.use_empty()) continue;
        ToErase.push_back(&I);
      }
    }

    for (Instruction *I : ToErase) {
      I->eraseFromParent();
      Changed = true;
      LocalChanged = true;
    }
  }

  return Changed;
}

//===----------------------------------------------------------------------===//
// Pass Entry Point
//===----------------------------------------------------------------------===//

PreservedAnalyses LCMPass::run(Function &F, FunctionAnalysisManager &AM) {
  LLVM_DEBUG(dbgs() << "[LCM] Running on function: " << F.getName() << "\n");

  // Retrieve analyses. DT and LI are passed into SplitAllCriticalEdges
  // so they are updated incrementally rather than invalidated.
  DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);
  LoopInfo &LI = AM.getResult<LoopAnalysis>(F);
  auto &TLI = AM.getResult<TargetLibraryAnalysis>(F);
  const auto &DL = F.getParent()->getDataLayout();
  // --- Briggs-Cooper Preprocessing ---

  // Step 1: Split critical edges so LCM has valid insertion points.
  // Note: ReassociatePass runs before LCMPass in the pipeline (GRA).
  bool CFGChanged = splitCriticalEdges(F, DT, LI);
  LLVM_DEBUG(if (CFGChanged) dbgs() << "[LCM] Critical edges split\n");

  // Step 2: Value numbering and candidate expression enumeration.
  DenseMap<Value *, uint32_t> ValueNumbers;
  DenseMap<uint32_t, Value*> VNToValue;
  SmallVector<LCMExpression, 64> Expressions;
  
  computeValueNumbers(F, ValueNumbers, VNToValue, Expressions);

  if (Expressions.empty()) {
    LLVM_DEBUG(dbgs() << "[LCM] No candidate expressions found, skipping\n");
    return CFGChanged ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }

  unsigned NumExprs = Expressions.size();
  // --- LCM Dataflow Passes ---

  DenseMap<BasicBlock *, BlockInfo> BlockData;

  // Step 3: Compute local ANTLOC and TRANSP sets per block.
  computeLocalSets(F, Expressions, ValueNumbers, BlockData);

  // Step 4: Backward pass — anticipability (ANTIN, ANTOUT).
  computeAnticipability(F, BlockData, NumExprs);

  // Step 5: Forward pass — availability (AVIN, AVOUT).
  computeAvailability(F, BlockData, NumExprs);

  // Step 6: Algebraic derivation — earliest placement.
  computeEarliest(F, BlockData, NumExprs);

  // Step 7: Forward pass — lateness/laziness (DELAY, LATEST).
  computeLateness(F, DT, BlockData, NumExprs);

  // Step 8: Backward pass — isolated points.
  computeIsolated(F, BlockData, NumExprs);

  // Step 9: Insert new temporaries and replace original computations.
  insertAndReplace(F, Expressions, BlockData, ValueNumbers, VNToValue, DT, NumExprs);

  bool Changed = true;
  while (Changed) {
    Changed = false;
    Changed |= simplifyInsertedPHIs(F);
    Changed |= simplifyInsertedInstructions(F, DL, &TLI, DT);
    Changed |= removeDeadLCMInserts(F);
  }
  
  // DT and LI were updated incrementally by splitCriticalEdges.
  // All other analyses are invalidated by our IR transformations.
  PreservedAnalyses PA;
  PA.preserve<DominatorTreeAnalysis>();
  PA.preserve<LoopAnalysis>();
  return PA;
}
