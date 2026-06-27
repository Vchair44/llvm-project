define i32 @test_threeway(i32 %a, i32 %b, i32 %c) {
entry:
  br i1 undef, label %one, label %two
one:
  %x = add i32 %a, %b
  br i1 undef, label %three, label %merge
two:
  %y = add i32 %a, %b
  br label %merge
three:
  %z = add i32 %a, %b
  br label %merge
merge:
  ret i32 0
}