; test_mixed.ll — Comprehensive LCM test suite
;
; Covers the following scenarios across multiple expressions and variables:
;
;  T1 — Full redundancy (CSE): expression available on ALL paths to a use
;  T2 — Loop-invariant code motion: expression inside loop, operands defined outside
;  T3 — Partial redundancy (classic LCM): expression on some but not all paths
;  T4 — No redundancy: expression only appears once, should not be moved
;  T5 — Partial redundancy through critical edge: route0/route1 style from analysis
;  T6 — Multiple independent expressions in same function
;  T7 — Nested expressions (b+c feeds into (b+c)+d)
;  T8 — Commutative canonicalization (a+b vs b+a should share a VN)
;  T9 — Expression killed by PHI (TRANSP=false at join point using different VN)
;  T10 — Expression anticipated but already available at entry (no insertion needed)
;
; All critical edges are pre-split manually (blocks ending in conditional branch
; that target blocks with multiple predecessors get an intermediate block).
; Functions are named test_TN for easy identification in opt output.
;
; Compile and run LCM with:
;   opt -passes=lcm -debug-only=lcm test_mixed.ll -S -o out.ll
;
;===-----------------------------------------------------------------------===;

;===-----------------------------------------------------------------------===;
; T1 — Full Redundancy / CSE
;
; %x = a + b computed in entry, then recomputed as %y in merge.
; LCM should:
;   INSERT in entry (or keep %x), REPLACE %y with %x.
;
; CFG: entry -> left -> merge
;      entry -> right -> merge
;
; Critical edges: entry->left and entry->right are not critical (entry has
; two successors, left/right each have one predecessor). left->merge and
; right->merge are not critical (merge has two predecessors but left/right
; each have one successor). No splitting needed.
;===-----------------------------------------------------------------------===;

define i32 @test_T1_full_redundancy(i32 %a, i32 %b, i1 %cond) {
entry:
  %x = add i32 %a, %b
  br i1 %cond, label %left, label %right

left:
  br label %merge

right:
  br label %merge

merge:
  %y = add i32 %a, %b          ; fully redundant — %x dominates here
  ret i32 %y
}

;===-----------------------------------------------------------------------===;
; T2 — Loop-Invariant Code Motion
;
; %a + %b is invariant (operands defined outside loop).
; LCM should hoist the computation to loop.preheader.
;
; CFG (after critical edge split on back edge):
;   entry -> loop.header -> loop.body -> loop.latch -> loop.header (back)
;                        -> exit
;
; loop.latch is the split block on the back edge (loop.body -> loop.header
; is critical: loop.body has one successor but loop.header has two predecessors).
;===-----------------------------------------------------------------------===;

define i32 @test_T2_licm(i32 %a, i32 %b, i32 %n) {
entry:
  br label %loop.header

loop.header:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop.latch ]
  %done = icmp sge i32 %i, %n
  br i1 %done, label %exit, label %loop.body

loop.body:
  %inv = add i32 %a, %b        ; loop-invariant — should be hoisted to entry
  %i.next = add i32 %i, 1
  br label %loop.latch

loop.latch:
  br label %loop.header

exit:
  ret i32 0
}

;===-----------------------------------------------------------------------===;
; T3 — Classic Partial Redundancy (diamond with one missing computation)
;
; %a + %b computed on right path only. Partially redundant at merge.
; LCM should:
;   INSERT on left.merge_crit (the split left->merge edge),
;   REPLACE %z in merge with the inserted temporary.
;
; CFG (critical edges pre-split):
;   entry -> left -> left.merge_crit -> merge
;   entry -> right -> right.merge_crit -> merge
;   merge -> exit
;===-----------------------------------------------------------------------===;

define i32 @test_T3_partial_redundancy(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:
  br label %left.merge_crit

left.merge_crit:
  br label %merge

right:
  %y = add i32 %a, %b
  br label %right.merge_crit

right.merge_crit:
  br label %merge

merge:
  %z = add i32 %a, %b          ; partially redundant — missing on left path
  ret i32 %z
}

;===-----------------------------------------------------------------------===;
; T4 — No Redundancy
;
; Each expression computed exactly once on every path, no duplication.
; LCM should leave the program unchanged.
;===-----------------------------------------------------------------------===;

define i32 @test_T4_no_redundancy(i32 %a, i32 %b, i32 %c, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:
  %x = add i32 %a, %b          ; only on left path
  ret i32 %x

right:
  %y = add i32 %b, %c          ; only on right path, different expression
  ret i32 %y
}

;===-----------------------------------------------------------------------===;
; T5 — Partial Redundancy Through Critical Edges (route0/route1 style)
;
; Mirrors the program analyzed in depth:
;   route1 computes a+b, route2 and route3 also compute a+b.
;   route0 never computes a+b.
;
; LCM should:
;   INSERT in route0.route2_crit and route0.route3_crit,
;   REPLACE (keep) %x in route1,
;   REPLACE %y in route2 and %z in route3.
;
; CFG (critical edges pre-split):
;   entry -> route0 -> route0.route2_crit -> route2 -> route4
;                   -> route0.route3_crit -> route3 -> route4
;   entry -> route1 -> route1.route2_crit -> route2
;                   -> route1.route3_crit -> route3
;===-----------------------------------------------------------------------===;

define i32 @test_T5_route0_route1(i32 %a, i32 %b, i1 %cond0, i1 %cond1, i1 %cond2) {
entry:
  br i1 %cond0, label %route0, label %route1

route0:
  br i1 %cond1, label %route0.route2_crit, label %route0.route3_crit

route0.route2_crit:
  br label %route2

route0.route3_crit:
  br label %route3

route1:
  %x = add i32 %a, %b
  br i1 %cond2, label %route1.route2_crit, label %route1.route3_crit

route1.route2_crit:
  br label %route2

route1.route3_crit:
  br label %route3

route2:
  %y = add i32 %a, %b          ; partially redundant on route0 path
  br label %route4

route3:
  %z = add i32 %a, %b          ; partially redundant on route0 path
  br label %route4

route4:
  ret i32 0
}

;===-----------------------------------------------------------------------===;
; T6 — Multiple Independent Expressions in Same Function
;
; Three independent expressions: a+b, c+d, a*c.
; Each has its own partial redundancy pattern.
; Tests that bitvectors for different expressions don't interfere.
;
; a+b:  computed in entry and merge — full redundancy in merge
; c+d:  computed only in right — partial redundancy, should insert on left crit
; a*c:  computed only in entry — no redundancy downstream
;===-----------------------------------------------------------------------===;

define i32 @test_T6_multiple_exprs(i32 %a, i32 %b, i32 %c, i32 %d, i1 %cond) {
entry:
  %ab = add i32 %a, %b         ; a+b first occurrence
  %ac = mul i32 %a, %c         ; a*c — no downstream redundancy
  br i1 %cond, label %left, label %right

left:
  br label %left.merge_crit

left.merge_crit:
  br label %merge

right:
  %cd = add i32 %c, %d         ; c+d first occurrence
  br label %right.merge_crit

right.merge_crit:
  br label %merge

merge:
  %ab2 = add i32 %a, %b        ; fully redundant — %ab dominates
  %cd2 = add i32 %c, %d        ; partially redundant — missing on left path
  %result = add i32 %ab2, %cd2
  ret i32 %result
}

;===-----------------------------------------------------------------------===;
; T7 — Nested / Dependent Expressions
;
; %t1 = b + c  (inner)
; %t2 = t1 + d (outer, depends on t1)
;
; Both are partially redundant: computed in right, expected at merge.
; LCM must handle ordering — insert inner before outer.
; Tests that operand resolution works for inserted instructions that
; themselves depend on other inserted instructions.
;===-----------------------------------------------------------------------===;

define i32 @test_T7_nested_exprs(i32 %b, i32 %c, i32 %d, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:
  br label %left.merge_crit

left.merge_crit:
  br label %merge

right:
  %t1 = add i32 %b, %c         ; inner expression
  %t2 = add i32 %t1, %d        ; outer expression depending on %t1
  br label %right.merge_crit

right.merge_crit:
  br label %merge

merge:
  %s1 = add i32 %b, %c         ; partially redundant inner
  %s2 = add i32 %s1, %d        ; partially redundant outer
  ret i32 %s2
}

;===-----------------------------------------------------------------------===;
; T8 — Commutative Canonicalization
;
; a+b and b+a should receive the same value number after canonicalization
; (swap operands so lower VN comes first for commutative ops).
; LCM should treat %p and %q as the same expression.
;===-----------------------------------------------------------------------===;

define i32 @test_T8_commutative(i32 %a, i32 %b, i1 %cond) {
entry:
  %p = add i32 %a, %b          ; a+b
  br i1 %cond, label %left, label %right

left:
  br label %merge

right:
  br label %merge

merge:
  %q = add i32 %b, %a          ; b+a — same value after canonicalization
  ret i32 %q                   ; should be replaced with %p
}

;===-----------------------------------------------------------------------===;
; T9 — PHI Kills Transparency (TRANSP = false)
;
; A PHI at loop.header redefines %a.next which is an operand of the expression.
; The expression %a.next + %b is NOT transparent through loop.header because
; the PHI produces a new VN for what feeds into the expression.
; LCM must NOT hoist this expression — it is not loop-invariant.
;
; This tests that the TRANSP loop correctly detects PHI-induced kills.
;===-----------------------------------------------------------------------===;

define i32 @test_T9_phi_kills_transp(i32 %a0, i32 %b, i32 %n) {
entry:
  br label %loop.header

loop.header:
  %a = phi i32 [ %a0, %entry ], [ %a.next, %loop.latch ]
  %done = icmp sge i32 %a, %n
  br i1 %done, label %exit, label %loop.body

loop.body:
  %val = add i32 %a, %b        ; NOT invariant — %a changes each iteration
  %a.next = add i32 %a, 1
  br label %loop.latch

loop.latch:
  br label %loop.header

exit:
  ret i32 0
}

;===-----------------------------------------------------------------------===;
; T10 — Expression Anticipated at Entry, Already Available
;
; %a + %b is computed at the very start of entry and used again in merge.
; AVIN(merge) should be 1 (available on all paths through left and right).
; EARLIEST(merge) = ANTIN & ~AVIN = 0 — no insertion needed at merge.
; REPLACE should fire at merge.
;
; Also tests that a use in a return doesn't cause spurious insertion.
;===-----------------------------------------------------------------------===;

define i32 @test_T10_available_at_entry(i32 %a, i32 %b, i1 %cond) {
entry:
  %first = add i32 %a, %b      ; available from here on all paths
  br i1 %cond, label %left, label %right

left:
  %lv = add i32 %a, 1          ; unrelated, keeps left non-trivial
  br label %merge

right:
  %rv = add i32 %b, 1          ; unrelated
  br label %merge

merge:
  %second = add i32 %a, %b     ; fully redundant — %first dominates
  %result = add i32 %second, %first
  ret i32 %result
}

;===-----------------------------------------------------------------------===;
; T11 — Comparison Expression Partial Redundancy
;
; Tests that CmpInst (icmp) is handled as a candidate expression,
; not just BinaryOperator. The predicate must be included in the
; value number hash to distinguish slt from sgt etc.
;===-----------------------------------------------------------------------===;

define i1 @test_T11_cmp_expr(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:
  br label %left.merge_crit

left.merge_crit:
  br label %merge

right:
  %c1 = icmp slt i32 %a, %b    ; comparison on right path only
  br label %right.merge_crit

right.merge_crit:
  br label %merge

merge:
  %c2 = icmp slt i32 %a, %b    ; partially redundant
  ret i1 %c2
}

;===-----------------------------------------------------------------------===;
; T12 — Multiple Uses of Inserted Temporary
;
; After LCM inserts h = a+b in entry, both %p in left and %q in right
; should be replaced with h. Tests that replaceAllUsesWith correctly
; propagates to multiple REPLACE sites dominated by one INSERT site.
;===-----------------------------------------------------------------------===;

define i32 @test_T12_multiple_replace_sites(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:
  %p = add i32 %a, %b          ; one REPLACE site
  %lres = add i32 %p, 1
  ret i32 %lres

right:
  %q = add i32 %a, %b          ; another REPLACE site
  %rres = add i32 %q, 2
  ret i32 %rres
}

;===-----------------------------------------------------------------------===;
; T13 — Expression Dead After Insertion (ISOLATED suppresses)
;
; a+b is anticipated in left and right but the only downstream uses
; are immediately in those blocks with no further propagation.
; ISOLATED should prevent a spurious insertion at entry.
;===-----------------------------------------------------------------------===;

define i32 @test_T13_isolated(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:
  %x = add i32 %a, %b
  ret i32 %x                   ; use is right here — no benefit to hoisting

right:
  %y = add i32 %a, %b
  ret i32 %y                   ; same
}

;===-----------------------------------------------------------------------===;
; T14 — Long Chain: Redundancy Across Three Levels of Depth
;
; a+b computed in level1, recomputed in level2, recomputed in level3.
; LCM should insert once at level1 and replace in level2 and level3.
; Tests that AVOUT propagates correctly through a straight-line chain.
;===-----------------------------------------------------------------------===;

define i32 @test_T14_chain_redundancy(i32 %a, i32 %b) {
entry:
  br label %level1

level1:
  %v1 = add i32 %a, %b
  br label %level2

level2:
  %v2 = add i32 %a, %b         ; redundant — %v1 available
  br label %level3

level3:
  %v3 = add i32 %a, %b         ; redundant — %v1 still available
  ret i32 %v3
}
