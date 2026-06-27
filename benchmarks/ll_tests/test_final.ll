define i32 @test(i32 %a, i32 %b, i1 %cond0, i1 %cond1, i1 %cond2) {
entry:
  br i1 %cond0, label %route0, label %route1

route0:
  br i1 %cond1, label %route2, label %route3

route1:
  %x = add i32 %a, %b
  br i1 %cond2, label %route2, label %route3

route2:
  %y = add i32 %a, %b
  br label %route4

route3:
  %z = add i32 %a, %b
  br label %route4

route4:
  ret i32 0
}