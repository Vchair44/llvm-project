define i32 @test_constants(i32 %a) {
entry:
  %x = add i32 %a, 1
  %y = add i32 %a, 1
  %z = add i32 %a, 2
  ret i32 %y
}