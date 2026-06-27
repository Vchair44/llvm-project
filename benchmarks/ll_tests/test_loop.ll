define i32 @test_loop(i32 %a, i32 %b) {
entry:
  br label %loop
loop:
  %x = add i32 %a, %b
  br i1 undef, label %loop, label %exit
exit:
  %y = add i32 %a, %b
  ret i32 %y
}