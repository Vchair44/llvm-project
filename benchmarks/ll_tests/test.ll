define i32 @test(i32 %a, i32 %b) {
entry:
  %x = add i32 %a, %b
  %y = add i32 %a, %b
  ret i32 %y
}