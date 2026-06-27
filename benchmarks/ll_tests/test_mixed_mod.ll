; ModuleID = 'test_mixed.ll'
source_filename = "test_mixed.ll"

define i32 @test_T1_full_redundancy(i32 %a, i32 %b, i1 %cond) {
entry:
  %x = add i32 %a, %b
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  br label %merge

right:                                            ; preds = %entry
  br label %merge

merge:                                            ; preds = %right, %left
  ret i32 %x
}

define i32 @test_T2_licm(i32 %a, i32 %b, i32 %n) {
entry:
  br label %loop.header

loop.header:                                      ; preds = %loop.latch, %entry
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop.latch ]
  %done = icmp sge i32 %i, %n
  br i1 %done, label %exit, label %loop.body

loop.body:                                        ; preds = %loop.header
  %inv = add i32 %a, %b
  %i.next = add i32 %i, 1
  br label %loop.latch

loop.latch:                                       ; preds = %loop.body
  br label %loop.header

exit:                                             ; preds = %loop.header
  ret i32 0
}

define i32 @test_T3_partial_redundancy(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  br label %left.merge_crit

left.merge_crit:                                  ; preds = %left
  %lcm.tmp = add i32 %a, %b
  br label %merge

right:                                            ; preds = %entry
  %y = add i32 %a, %b
  br label %right.merge_crit

right.merge_crit:                                 ; preds = %right
  br label %merge

merge:                                            ; preds = %right.merge_crit, %left.merge_crit
  %lcm.phi = phi i32 [ %y, %right.merge_crit ], [ %lcm.tmp, %left.merge_crit ]
  ret i32 %lcm.phi
}

define i32 @test_T4_no_redundancy(i32 %a, i32 %b, i32 %c, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  %x = add i32 %a, %b
  ret i32 %x

right:                                            ; preds = %entry
  %y = add i32 %b, %c
  ret i32 %y
}

define i32 @test_T5_route0_route1(i32 %a, i32 %b, i1 %cond0, i1 %cond1, i1 %cond2) {
entry:
  br i1 %cond0, label %route0, label %route1

route0:                                           ; preds = %entry
  br i1 %cond1, label %route0.route2_crit, label %route0.route3_crit

route0.route2_crit:                               ; preds = %route0
  %lcm.tmp1 = add i32 %a, %b
  br label %route2

route0.route3_crit:                               ; preds = %route0
  %lcm.tmp = add i32 %a, %b
  br label %route3

route1:                                           ; preds = %entry
  %x = add i32 %a, %b
  br i1 %cond2, label %route1.route2_crit, label %route1.route3_crit

route1.route2_crit:                               ; preds = %route1
  br label %route2

route1.route3_crit:                               ; preds = %route1
  br label %route3

route2:                                           ; preds = %route1.route2_crit, %route0.route2_crit
  %lcm.phi2 = phi i32 [ %x, %route1.route2_crit ], [ %lcm.tmp1, %route0.route2_crit ]
  br label %route4

route3:                                           ; preds = %route1.route3_crit, %route0.route3_crit
  %lcm.phi = phi i32 [ %x, %route1.route3_crit ], [ %lcm.tmp, %route0.route3_crit ]
  br label %route4

route4:                                           ; preds = %route3, %route2
  ret i32 0
}

define i32 @test_T6_multiple_exprs(i32 %a, i32 %b, i32 %c, i32 %d, i1 %cond) {
entry:
  %ab = add i32 %a, %b
  %ac = mul i32 %a, %c
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  br label %left.merge_crit

left.merge_crit:                                  ; preds = %left
  %lcm.tmp = add i32 %c, %d
  br label %merge

right:                                            ; preds = %entry
  %cd = add i32 %c, %d
  br label %right.merge_crit

right.merge_crit:                                 ; preds = %right
  br label %merge

merge:                                            ; preds = %right.merge_crit, %left.merge_crit
  %lcm.phi = phi i32 [ %cd, %right.merge_crit ], [ %lcm.tmp, %left.merge_crit ]
  %result = add i32 %ab, %lcm.phi
  ret i32 %result
}

define i32 @test_T7_nested_exprs(i32 %b, i32 %c, i32 %d, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  br label %left.merge_crit

left.merge_crit:                                  ; preds = %left
  %lcm.tmp = add i32 %b, %c
  %lcm.tmp1 = add i32 %lcm.tmp, %d
  br label %merge

right:                                            ; preds = %entry
  %t1 = add i32 %b, %c
  %t2 = add i32 %t1, %d
  br label %right.merge_crit

right.merge_crit:                                 ; preds = %right
  br label %merge

merge:                                            ; preds = %right.merge_crit, %left.merge_crit
  %lcm.phi2 = phi i32 [ %t2, %right.merge_crit ], [ %lcm.tmp1, %left.merge_crit ]
  %lcm.phi = phi i32 [ %t1, %right.merge_crit ], [ %lcm.tmp, %left.merge_crit ]
  ret i32 %lcm.phi2
}

define i32 @test_T8_commutative(i32 %a, i32 %b, i1 %cond) {
entry:
  %p = add i32 %a, %b
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  br label %merge

right:                                            ; preds = %entry
  br label %merge

merge:                                            ; preds = %right, %left
  ret i32 %p
}

define i32 @test_T9_phi_kills_transp(i32 %a0, i32 %b, i32 %n) {
entry:
  br label %loop.header

loop.header:                                      ; preds = %loop.latch, %entry
  %a = phi i32 [ %a0, %entry ], [ %a.next, %loop.latch ]
  %done = icmp sge i32 %a, %n
  br i1 %done, label %exit, label %loop.body

loop.body:                                        ; preds = %loop.header
  %val = add i32 %a, %b
  %a.next = add i32 %a, 1
  br label %loop.latch

loop.latch:                                       ; preds = %loop.body
  br label %loop.header

exit:                                             ; preds = %loop.header
  ret i32 0
}

define i32 @test_T10_available_at_entry(i32 %a, i32 %b, i1 %cond) {
entry:
  %first = add i32 %a, %b
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  %lv = add i32 %a, 1
  br label %merge

right:                                            ; preds = %entry
  %rv = add i32 %b, 1
  br label %merge

merge:                                            ; preds = %right, %left
  %result = add i32 %first, %first
  ret i32 %result
}

define i1 @test_T11_cmp_expr(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  br label %left.merge_crit

left.merge_crit:                                  ; preds = %left
  %lcm.tmp = icmp slt i32 %a, %b
  br label %merge

right:                                            ; preds = %entry
  %c1 = icmp slt i32 %a, %b
  br label %right.merge_crit

right.merge_crit:                                 ; preds = %right
  br label %merge

merge:                                            ; preds = %right.merge_crit, %left.merge_crit
  %lcm.phi = phi i1 [ %c1, %right.merge_crit ], [ %lcm.tmp, %left.merge_crit ]
  ret i1 %lcm.phi
}

define i32 @test_T12_multiple_replace_sites(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  %p = add i32 %a, %b
  %lres = add i32 %p, 1
  ret i32 %lres

right:                                            ; preds = %entry
  %q = add i32 %a, %b
  %rres = add i32 %q, 2
  ret i32 %rres
}

define i32 @test_T13_isolated(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right

left:                                             ; preds = %entry
  %x = add i32 %a, %b
  ret i32 %x

right:                                            ; preds = %entry
  %y = add i32 %a, %b
  ret i32 %y
}

define i32 @test_T14_chain_redundancy(i32 %a, i32 %b) {
entry:
  br label %level1

level1:                                           ; preds = %entry
  %v1 = add i32 %a, %b
  br label %level2

level2:                                           ; preds = %level1
  br label %level3

level3:                                           ; preds = %level2
  ret i32 %v1
}
