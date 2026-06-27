#ifndef LLVM_TRANSFORMS_SCALAR_LCM_H
#define LLVM_TRANSFORMS_SCALAR_LCM_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class LCMPass : public PassInfoMixin<LCMPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif
