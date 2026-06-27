; ModuleID = 'benchmarks/lcm_vs_gvn.cpp'
source_filename = "benchmarks/lcm_vs_gvn.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"Result: %lld\0A\00", align 1

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i32 @_Z12deep_diamondiiiiiiiib(i32 noundef %a, i32 noundef %b, i32 noundef %c, i32 noundef %d, i32 noundef %e, i32 noundef %f, i32 noundef %g, i32 noundef %h, i1 noundef zeroext %cond) local_unnamed_addr #0 {
entry:
  %xor = xor i32 %b, %a
  %xor1 = xor i32 %d, %c
  %xor2 = xor i32 %f, %e
  %xor3 = xor i32 %h, %g
  %add = add nsw i32 %e, %a
  %add4 = add nsw i32 %f, %b
  %add5 = add nsw i32 %g, %c
  %add6 = add nsw i32 %h, %d
  %lcm.tmp = mul nsw i32 %b, %a
  %lcm.tmp84 = mul nsw i32 %d, %c
  br i1 %cond, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %mul = mul nsw i32 %xor1, %xor
  %mul8 = mul nsw i32 %xor3, %xor2
  %mul10 = mul nsw i32 %add4, %add
  %mul12 = mul nsw i32 %add6, %add5
  %xor14 = xor i32 %add, %xor
  %xor16 = xor i32 %add4, %xor1
  %xor18 = xor i32 %add5, %xor2
  %xor20 = xor i32 %xor3, %add6
  %add9 = add i32 %xor14, %mul
  %add11 = add i32 %add9, %mul10
  %add13 = add i32 %add11, %xor16
  %add15 = add i32 %add13, %xor18
  %add17 = add i32 %add15, %mul8
  %add19 = add i32 %add17, %mul12
  %add21 = add nsw i32 %add19, %xor20
  br label %if.end

if.else:                                          ; preds = %entry
  %add24 = add i32 %xor, %lcm.tmp
  %add22 = add i32 %add24, %lcm.tmp84
  %add25 = add i32 %add22, %xor1
  %add26 = add i32 %add25, %add
  %add27 = add i32 %add26, %add4
  %add28 = add i32 %add27, %xor2
  %add29 = add i32 %add28, %add5
  %add32 = add i32 %add29, %add6
  %add33 = add i32 %add32, %xor3
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %result.0 = phi i32 [ %add33, %if.else ], [ %add21, %if.then ]
  %add36 = add nsw i32 %lcm.tmp84, %lcm.tmp
  %add37 = add nsw i32 %add36, %result.0
  ret i32 %add37
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i32 @_Z10three_pathiiiii(i32 noundef %a, i32 noundef %b, i32 noundef %c, i32 noundef %d, i32 noundef %selector) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i32 %a, 3
  %mul1 = mul nsw i32 %b, 7
  %add = add nsw i32 %mul1, %mul
  %mul2 = mul nsw i32 %c, 5
  %mul3 = mul nsw i32 %d, 11
  %add4 = add nsw i32 %mul3, %mul2
  %mul5 = mul nsw i32 %b, %a
  %add6 = add nsw i32 %mul5, %c
  %mul7 = mul nsw i32 %c, %b
  %add8 = add nsw i32 %mul7, %d
  %mul9 = mul nsw i32 %c, %a
  %mul10 = mul nsw i32 %d, %b
  %add11 = add nsw i32 %mul10, %mul9
  %xor = xor i32 %b, %a
  %xor12 = xor i32 %d, %c
  %mul13 = mul nsw i32 %xor12, %xor
  %mul33 = mul nsw i32 %d, %c
  switch i32 %selector, label %if.else28 [
    i32 0, label %if.then
    i32 1, label %if.then20
  ]

if.then:                                          ; preds = %entry
  %mul14 = mul nsw i32 %add4, %add
  %mul15 = mul nsw i32 %add8, %add6
  %add16 = add nsw i32 %mul14, %mul15
  %mul17 = mul nsw i32 %add11, %mul13
  %add18 = add nsw i32 %add16, %mul17
  br label %if.end36

if.then20:                                        ; preds = %entry
  %add21 = add i32 %add, %mul5
  %add22 = add i32 %add21, %add6
  %add23 = add i32 %add22, %mul33
  %add26 = add i32 %add23, %add8
  %add27 = add i32 %add26, %add4
  br label %if.end36

if.else28:                                        ; preds = %entry
  %add29 = add i32 %add, %mul5
  %add30 = add i32 %add29, %mul33
  %add31 = add i32 %add30, %mul13
  %add34 = add i32 %add31, %add11
  %add35 = add i32 %add34, %add4
  br label %if.end36

if.end36:                                         ; preds = %if.then20, %if.else28, %if.then
  %result.0 = phi i32 [ %add27, %if.then20 ], [ %add35, %if.else28 ], [ %add18, %if.then ]
  %add39 = add nsw i32 %mul33, %mul5
  %add40 = add nsw i32 %add39, %result.0
  %0 = xor i32 %add6, %add40
  %xor42 = xor i32 %0, %add8
  ret i32 %xor42
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i32 @_Z12loop_partialiiii(i32 noundef %a, i32 noundef %b, i32 noundef %c, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %xor = xor i32 %b, %a
  %xor1 = xor i32 %c, %b
  %xor2 = xor i32 %c, %a
  %cmp62 = icmp sgt i32 %n, 0
  br i1 %cmp62, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %mul1361 = add i32 %c, %a
  %add15 = mul i32 %mul1361, %b
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %result.0.lcssa = phi i32 [ 0, %entry ], [ %result.1, %for.body ]
  %acc0.0.lcssa = phi i32 [ %a, %entry ], [ %add, %for.body ]
  %acc1.0.lcssa = phi i32 [ %b, %entry ], [ %add4, %for.body ]
  %acc2.0.lcssa = phi i32 [ %c, %entry ], [ %add6, %for.body ]
  %acc3.0.lcssa = phi i32 [ %xor, %entry ], [ %xor8, %for.body ]
  %acc4.0.lcssa = phi i32 [ %xor1, %entry ], [ %xor10, %for.body ]
  %acc5.0.lcssa = phi i32 [ %xor2, %entry ], [ %xor12, %for.body ]
  %mul1760 = add i32 %c, %a
  %add19 = mul i32 %mul1760, %b
  %add20 = add nsw i32 %result.0.lcssa, %add19
  %xor21 = xor i32 %add20, %acc0.0.lcssa
  %xor22 = xor i32 %xor21, %acc1.0.lcssa
  %xor23 = xor i32 %xor22, %acc2.0.lcssa
  %xor24 = xor i32 %xor23, %acc3.0.lcssa
  %xor25 = xor i32 %xor24, %acc4.0.lcssa
  %xor26 = xor i32 %xor25, %acc5.0.lcssa
  ret i32 %xor26

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %i.070 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %acc5.069 = phi i32 [ %xor2, %for.body.lr.ph ], [ %xor12, %for.body ]
  %acc4.068 = phi i32 [ %xor1, %for.body.lr.ph ], [ %xor10, %for.body ]
  %acc3.067 = phi i32 [ %xor, %for.body.lr.ph ], [ %xor8, %for.body ]
  %acc2.066 = phi i32 [ %c, %for.body.lr.ph ], [ %add6, %for.body ]
  %acc1.065 = phi i32 [ %b, %for.body.lr.ph ], [ %add4, %for.body ]
  %acc0.064 = phi i32 [ %a, %for.body.lr.ph ], [ %add, %for.body ]
  %result.063 = phi i32 [ 0, %for.body.lr.ph ], [ %result.1, %for.body ]
  %mul = mul nsw i32 %acc0.064, 1000003
  %add = add nsw i32 %i.070, %mul
  %mul3 = mul nsw i32 %acc1.065, 998244353
  %add4 = add nsw i32 %add, %mul3
  %mul5 = mul nsw i32 %acc2.066, 1000000007
  %add6 = add nsw i32 %add4, %mul5
  %mul7 = mul nsw i32 %add6, %add
  %xor8 = xor i32 %mul7, %acc3.067
  %mul9 = mul nsw i32 %xor8, %add4
  %xor10 = xor i32 %mul9, %acc4.068
  %mul11 = mul nsw i32 %xor10, %add6
  %xor12 = xor i32 %mul11, %acc5.069
  %and = and i32 %i.070, 1
  %tobool.not = icmp eq i32 %and, 0
  %add16 = select i1 %tobool.not, i32 0, i32 %add15
  %result.1 = add nsw i32 %add16, %result.063
  %inc = add nuw nsw i32 %i.070, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !9
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i32 @_Z14nested_partialiiibb(i32 noundef %a, i32 noundef %b, i32 noundef %c, i1 noundef zeroext %cond0, i1 noundef zeroext %cond1) local_unnamed_addr #0 {
entry:
  br i1 %cond0, label %if.then, label %if.else9

if.then:                                          ; preds = %entry
  %mul = mul nsw i32 %a, 3
  %lcm.tmp49 = add nsw i32 %a, %b
  %lcm.tmp50 = mul nsw i32 %c, %lcm.tmp49
  br i1 %cond1, label %if.then3, label %if.else

if.then3:                                         ; preds = %if.then
  %mul4 = mul nsw i32 %b, 7
  %add5 = add nsw i32 %mul4, %mul
  br label %if.end12

if.else:                                          ; preds = %if.then
  %add8 = add nsw i32 %lcm.tmp50, %mul
  br label %if.end12

if.else9:                                         ; preds = %entry
  %lcm.tmp = add nsw i32 %a, %b
  %lcm.tmp46 = mul nsw i32 %c, %lcm.tmp
  %mul10 = mul nsw i32 %c, 11
  br label %if.end12

if.end12:                                         ; preds = %if.then3, %if.else, %if.else9
  %lcm.phi53 = phi i32 [ %lcm.tmp50, %if.then3 ], [ %lcm.tmp50, %if.else ], [ %lcm.tmp46, %if.else9 ]
  %lcm.phi = phi i32 [ %lcm.tmp49, %if.then3 ], [ %lcm.tmp49, %if.else ], [ %lcm.tmp, %if.else9 ]
  %result.0 = phi i32 [ %add5, %if.then3 ], [ %add8, %if.else ], [ %mul10, %if.else9 ]
  %mul17 = shl nsw i32 %lcm.phi, 1
  %mul17.pn = select i1 %cond1, i32 %mul17, i32 %lcm.phi53
  %add14 = add i32 %lcm.phi53, %lcm.phi
  %result.1 = add i32 %add14, %mul17.pn
  %add25 = add i32 %result.1, %result.0
  ret i32 %add25
}

; Function Attrs: mustprogress norecurse nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %argc, ptr noundef readonly captures(none) %argv) local_unnamed_addr #2 {
entry:
  %sink = alloca i64, align 8
  %cmp = icmp sgt i32 %argc, 1
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %arrayidx = getelementptr inbounds nuw i8, ptr %argv, i64 8
  %0 = load ptr, ptr %arrayidx, align 8, !tbaa !11
  %call.i = tail call i64 @__isoc23_strtol(ptr noundef nonnull %0, ptr noundef null, i32 noundef 10) #5
  %conv.i = trunc i64 %call.i to i32
  br label %cond.end

cond.end:                                         ; preds = %entry, %cond.true
  %cond = phi i32 [ %conv.i, %cond.true ], [ 42, %entry ]
  call void @llvm.lifetime.start.p0(ptr nonnull %sink)
  store volatile i64 0, ptr %sink, align 8, !tbaa !14
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %sink.0.sink.0.sink.0.sink.0.72 = load volatile i64, ptr %sink, align 8, !tbaa !14
  %call41 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %sink.0.sink.0.sink.0.sink.0.72)
  call void @llvm.lifetime.end.p0(ptr nonnull %sink)
  ret i32 0

for.body:                                         ; preds = %for.body, %cond.end
  %i.080 = phi i32 [ 0, %cond.end ], [ %inc, %for.body ]
  %mul = mul nsw i32 %i.080, %cond
  %mul2 = mul i32 %mul, 579
  %and = and i32 %mul2, 1023
  %and5 = and i32 %mul, 1023
  %mul7 = mul i32 %mul, 519
  %and8 = and i32 %mul7, 1023
  %mul10 = mul i32 %mul, 449
  %and11 = and i32 %mul10, 1023
  %xor = xor i32 %mul, %cond
  %xor12 = xor i32 %xor, %mul2
  %and13 = and i32 %xor12, 1023
  %xor15 = xor i32 %xor, %mul7
  %and16 = and i32 %xor15, 1023
  %xor17 = xor i32 %mul10, %cond
  %xor18 = xor i32 %xor17, %mul7
  %and19 = and i32 %xor18, 1023
  %xor20 = xor i32 %mul2, %cond
  %xor21 = xor i32 %xor20, %mul10
  %and22 = and i32 %xor21, 1023
  %and24 = and i32 %i.080, 1
  %cmp25 = icmp ne i32 %and24, 0
  %and26 = and i32 %i.080, 2
  %cmp27 = icmp ne i32 %and26, 0
  %rem = urem i32 %i.080, 3
  %call29 = tail call noundef i32 @_Z12deep_diamondiiiiiiiib(i32 noundef %and, i32 noundef %and5, i32 noundef %and8, i32 noundef %and11, i32 noundef %and13, i32 noundef %and16, i32 noundef %and19, i32 noundef %and22, i1 noundef zeroext %cmp25)
  %conv = sext i32 %call29 to i64
  %sink.0.sink.0.sink.0.sink.0. = load volatile i64, ptr %sink, align 8, !tbaa !14
  %add = add nsw i64 %sink.0.sink.0.sink.0.sink.0., %conv
  store volatile i64 %add, ptr %sink, align 8, !tbaa !14
  %call30 = tail call noundef i32 @_Z10three_pathiiiii(i32 noundef %and, i32 noundef %and5, i32 noundef %and8, i32 noundef %and11, i32 noundef %rem)
  %conv31 = sext i32 %call30 to i64
  %sink.0.sink.0.sink.0.sink.0.69 = load volatile i64, ptr %sink, align 8, !tbaa !14
  %add32 = add nsw i64 %sink.0.sink.0.sink.0.sink.0.69, %conv31
  store volatile i64 %add32, ptr %sink, align 8, !tbaa !14
  %call33 = tail call noundef i32 @_Z12loop_partialiiii(i32 noundef %and, i32 noundef %and5, i32 noundef %and8, i32 noundef 8)
  %conv34 = sext i32 %call33 to i64
  %sink.0.sink.0.sink.0.sink.0.70 = load volatile i64, ptr %sink, align 8, !tbaa !14
  %add35 = add nsw i64 %sink.0.sink.0.sink.0.sink.0.70, %conv34
  store volatile i64 %add35, ptr %sink, align 8, !tbaa !14
  %call38 = tail call noundef i32 @_Z14nested_partialiiibb(i32 noundef %and, i32 noundef %and5, i32 noundef %and8, i1 noundef zeroext %cmp25, i1 noundef zeroext %cmp27)
  %conv39 = sext i32 %call38 to i64
  %sink.0.sink.0.sink.0.sink.0.71 = load volatile i64, ptr %sink, align 8, !tbaa !14
  %add40 = add nsw i64 %sink.0.sink.0.sink.0.sink.0.71, %conv39
  store volatile i64 %add40, ptr %sink, align 8, !tbaa !14
  %inc = add nuw nsw i32 %i.080, 1
  %exitcond.not = icmp eq i32 %inc, 20000000
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !16
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #3

; Function Attrs: nounwind
declare i64 @__isoc23_strtol(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #4

attributes #0 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress norecurse nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}
!llvm.errno.tbaa = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 22.1.7 (https://github.com/Vchair44/llvm-project.git e07c6f974658af8b726142ee191a369b486e300c)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C++ TBAA"}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!12, !12, i64 0}
!12 = !{!"p1 omnipotent char", !13, i64 0}
!13 = !{!"any pointer", !7, i64 0}
!14 = !{!15, !15, i64 0}
!15 = !{!"long long", !7, i64 0}
!16 = distinct !{!16, !10}
