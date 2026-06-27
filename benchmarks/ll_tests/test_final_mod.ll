; ModuleID = 'test_final.ll'
source_filename = "test_final.ll"

define i32 @test(i32 %a, i32 %b, i1 %cond0, i1 %cond1, i1 %cond2) {
entry:
  br i1 %cond0, label %route0, label %route1

route0:                                           ; preds = %entry
  br i1 %cond1, label %route0.route2_crit_edge, label %route0.route3_crit_edge

route0.route3_crit_edge:                          ; preds = %route0
  br label %route3

route0.route2_crit_edge:                          ; preds = %route0
  br label %route2

route1:                                           ; preds = %entry
  %lcm.tmp = add i32 %a, %b
  %x = add i32 %a, %b
  br i1 %cond2, label %route1.route2_crit_edge, label %route1.route3_crit_edge

route1.route3_crit_edge:                          ; preds = %route1
  br label %route3

route1.route2_crit_edge:                          ; preds = %route1
  br label %route2

route2:                                           ; preds = %route1.route2_crit_edge, %route0.route2_crit_edge
  %lcm.tmp1 = add i32 %a, %b
  %y = add i32 %a, %b
  br label %route4

route3:                                           ; preds = %route1.route3_crit_edge, %route0.route3_crit_edge
  %lcm.tmp2 = add i32 %a, %b
  %z = add i32 %a, %b
  br label %route4

route4:                                           ; preds = %route3, %route2
  ret i32 0
}
