define i32 @test_different(i32 %a, i32 %b, i32 %c) {
entry:
  %x = add i32 %a, %b
  %y = add i32 %a, %c
  ret i32 %y
}