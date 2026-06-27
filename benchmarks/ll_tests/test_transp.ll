define i32 @test_transp(i32 %a, i32 %b, i32 %c, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right
left:
  br label %merge
right:
  br label %merge
merge:
  %a2 = phi i32 [ %a, %left ], [ %c, %right ]
  %x = add i32 %a2, %b
  ret i32 %x
}