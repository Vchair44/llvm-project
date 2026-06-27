define i32 @test_commute(i32 %a, i32 %b) {
entry:
  %x = add i32 %a, %b
  %y = add i32 %b, %a
  ret i32 %y
}