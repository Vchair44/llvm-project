define i32 @test_diamond_kill(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right
left:
  %x = add i32 %a, %b
  br label %merge
right:
  br label %merge
merge:
  %a2 = phi i32 [ %x, %left ], [ %a, %right ]
  %y = add i32 %a2, %b
  ret i32 %y
}