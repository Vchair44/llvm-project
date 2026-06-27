define i32 @test_blocks(i32 %a, i32 %b, i1 %cond) {
entry:
  %x = add i32 %a, %b
  br i1 %cond, label %left, label %right
left:
  %y = add i32 %a, %b
  br label %merge
right:
  %z = add i32 %a, %b
  br label %merge
merge:
  ret i32 0
}