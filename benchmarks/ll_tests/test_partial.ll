define i32 @test_partial(i32 %a, i32 %b, i1 %cond) {
entry:
  br i1 %cond, label %left, label %right
left:
  %x = add i32 %a, %b
  br label %merge
right:
  br label %merge
merge:
  ret i32 0
}