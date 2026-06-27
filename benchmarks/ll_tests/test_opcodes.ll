define i32 @test_opcodes(i32 %a, i32 %b) {
entry:
  %x = add i32 %a, %b
  %y = mul i32 %a, %b
  ret i32 %y
}