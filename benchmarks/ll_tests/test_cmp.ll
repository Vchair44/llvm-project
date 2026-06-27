define i1 @test_cmp(i32 %a, i32 %b) {
entry:
  %x = icmp eq i32 %a, %b
  %y = icmp slt i32 %a, %b
  %z = icmp eq i32 %a, %b
  ret i1 %z
}