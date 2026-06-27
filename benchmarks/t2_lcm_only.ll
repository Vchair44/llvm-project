; ModuleID = 'benchmarks/t2_raw.ll'
source_filename = "benchmarks/test2.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"Result: %lld\0A\00", align 1
@_ZL11global_sink = internal global i64 0, align 8

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @_Z18cascading_diamondsiiibbbb(i32 noundef %a, i32 noundef %b, i32 noundef %c, i1 noundef zeroext %d0, i1 noundef zeroext %d1, i1 noundef zeroext %d2, i1 noundef zeroext %d3) local_unnamed_addr #0 {
entry:
  %add = add nsw i32 %b, %a
  %add4 = add nsw i32 %c, %b
  %add5 = add nsw i32 %c, %a
  %add7 = add nsw i32 %add, %c
  %mul = mul nsw i32 %add, 1000003
  %mul8 = mul nsw i32 %add4, 998244353
  %mul9 = mul nsw i32 %add5, 999999937
  %mul10 = mul nsw i32 %add7, 1000000007
  br i1 %d0, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %lcm.tmp = xor i32 %b, %a
  %conv = sext i32 %mul to i64
  %conv11 = sext i32 %mul8 to i64
  %mul12 = mul nsw i64 %conv11, %conv
  br label %if.end

if.else:                                          ; preds = %entry
  %xor = xor i32 %mul9, %mul
  %conv18 = sext i32 %xor to i64
  %xor19 = xor i32 %mul8, %mul10
  %conv20 = sext i32 %xor19 to i64
  %mul21 = mul nsw i64 %conv18, %conv20
  %xor23 = xor i32 %b, %a
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %lcm.phi = phi i32 [ %xor23, %if.else ], [ %lcm.tmp, %if.then ]
  %xor23.sink = phi i32 [ %xor23, %if.else ], [ %mul9, %if.then ]
  %c.sink = phi i32 [ %c, %if.else ], [ %mul10, %if.then ]
  %mul21.sink = phi i64 [ %mul21, %if.else ], [ %mul12, %if.then ]
  %conv24 = sext i32 %xor23.sink to i64
  %conv25 = sext i32 %c.sink to i64
  %mul26 = mul nsw i64 %conv24, %conv25
  %add27 = add nsw i64 %mul21.sink, %mul26
  %conv29 = sext i32 %lcm.phi to i64
  %conv30 = sext i32 %c to i64
  %mul31 = mul nsw i64 %conv29, %conv30
  %add32 = add nsw i64 %add27, %mul31
  %shr = lshr i64 %add32, 3
  %conv33 = trunc i64 %shr to i32
  %xor34 = xor i32 %mul, %conv33
  %shr35 = lshr i64 %add32, 7
  %conv36 = trunc i64 %shr35 to i32
  %xor37 = xor i32 %mul8, %conv36
  %shr38 = lshr i64 %add32, 11
  %conv39 = trunc i64 %shr38 to i32
  %xor40 = xor i32 %mul9, %conv39
  %shr41 = lshr i64 %add32, 13
  %conv42 = trunc i64 %shr41 to i32
  %xor43 = xor i32 %mul10, %conv42
  br i1 %d1, label %if.then45, label %if.else59

if.then45:                                        ; preds = %if.end
  %conv46 = sext i32 %xor34 to i64
  %conv47 = sext i32 %xor37 to i64
  %mul48 = mul nsw i64 %conv46, %conv47
  %conv49 = sext i32 %xor40 to i64
  %conv50 = sext i32 %xor43 to i64
  %mul51 = mul nsw i64 %conv49, %conv50
  %xor54 = xor i32 %c, %b
  %conv55 = sext i32 %xor54 to i64
  %conv56 = sext i32 %a to i64
  %mul57 = mul nsw i64 %conv55, %conv56
  %add52 = add i64 %add32, %mul57
  %add53 = add i64 %add52, %mul51
  %add58 = add i64 %add53, %mul48
  br label %if.end71

if.else59:                                        ; preds = %if.end
  %lcm.tmp1 = xor i32 %b, %c
  %xor60 = xor i32 %xor34, %xor37
  %conv61 = sext i32 %xor60 to i64
  %xor62 = xor i32 %xor40, %xor43
  %conv63 = sext i32 %xor62 to i64
  %mul64 = mul nsw i64 %conv61, %conv63
  %add65 = add i64 %add32, %mul31
  %add70 = add i64 %add65, %mul64
  br label %if.end71

if.end71:                                         ; preds = %if.else59, %if.then45
  %lcm.phi4 = phi i32 [ %lcm.tmp1, %if.else59 ], [ %xor54, %if.then45 ]
  %acc.1 = phi i64 [ %add58, %if.then45 ], [ %add70, %if.else59 ]
  %conv73 = sext i32 %lcm.phi4 to i64
  %conv74 = sext i32 %a to i64
  %mul75 = mul nsw i64 %conv73, %conv74
  %add76 = add i64 %mul75, %mul31
  %add81 = add i64 %add76, %acc.1
  %shr82 = lshr i64 %add81, 17
  %xor83 = xor i64 %shr82, %add81
  %conv84 = trunc i64 %xor83 to i32
  %mul85 = mul nsw i32 %conv84, 1013904223
  %shr86 = lshr i64 %add81, 23
  %xor87 = xor i64 %shr86, %add81
  %conv88 = trunc i64 %xor87 to i32
  %mul89 = mul nsw i32 %conv88, 1664525
  br i1 %d2, label %if.then91, label %if.else121

if.then91:                                        ; preds = %if.end71
  br i1 %d3, label %if.then93, label %if.else108

if.then93:                                        ; preds = %if.then91
  %conv94 = sext i32 %mul85 to i64
  %conv95 = sext i32 %mul89 to i64
  %mul96 = mul nsw i64 %conv94, %conv95
  %xor98 = xor i32 %c, %a
  %conv99 = sext i32 %xor98 to i64
  %conv100 = sext i32 %b to i64
  %mul101 = mul nsw i64 %conv99, %conv100
  %add97 = add i64 %mul101, %mul75
  %add102 = add i64 %add97, %add81
  %add107 = add i64 %add102, %mul96
  br label %if.end146

if.else108:                                       ; preds = %if.then91
  %lcm.tmp3 = xor i32 %a, %c
  %xor109 = xor i32 %mul85, %mul89
  %conv110 = sext i32 %xor109 to i64
  %add111 = add nsw i32 %mul85, %mul89
  %conv112 = sext i32 %add111 to i64
  %mul113 = mul nsw i64 %conv110, %conv112
  %add114 = add i64 %add81, %mul31
  %add119 = add i64 %add114, %mul113
  br label %if.end146

if.else121:                                       ; preds = %if.end71
  br i1 %d3, label %if.then123, label %if.else138

if.then123:                                       ; preds = %if.else121
  %conv124 = sext i32 %mul85 to i64
  %conv125 = sext i32 %mul89 to i64
  %xor128 = xor i32 %c, %a
  %conv129 = sext i32 %xor128 to i64
  %conv130 = sext i32 %b to i64
  %mul131 = mul nsw i64 %conv129, %conv130
  %add126 = add i64 %mul131, %mul75
  %add127 = add i64 %add126, %add81
  %add132 = add i64 %add127, %conv125
  %add137 = add i64 %add132, %conv124
  br label %if.end146

if.else138:                                       ; preds = %if.else121
  %lcm.tmp2 = xor i32 %a, %c
  %mul139 = mul nsw i32 %mul85, %mul89
  %add141 = add nsw i32 %mul85, %mul89
  %xor143285 = xor i32 %mul139, %add141
  %xor143 = sext i32 %xor143285 to i64
  %add144 = add nsw i64 %add81, %xor143
  br label %if.end146

if.end146:                                        ; preds = %if.else138, %if.then123, %if.else108, %if.then93
  %lcm.phi5 = phi i32 [ %lcm.tmp2, %if.else138 ], [ %xor128, %if.then123 ], [ %lcm.tmp3, %if.else108 ], [ %xor98, %if.then93 ]
  %acc.2 = phi i64 [ %add107, %if.then93 ], [ %add119, %if.else108 ], [ %add137, %if.then123 ], [ %add144, %if.else138 ]
  %conv148 = sext i32 %lcm.phi5 to i64
  %conv149 = sext i32 %b to i64
  %mul150 = mul nsw i64 %conv148, %conv149
  %add151 = add i64 %mul150, %mul31
  %add156 = add i64 %add151, %mul75
  %add161 = add i64 %add156, %acc.2
  %conv162 = sext i32 %add to i64
  %conv163 = sext i32 %add4 to i64
  %mul164 = mul nsw i64 %conv163, %conv162
  %conv167 = sext i32 %add5 to i64
  %mul168 = mul nsw i64 %conv163, %conv167
  %mul172 = mul nsw i64 %conv167, %conv162
  %xor165 = xor i64 %mul168, %mul164
  %xor169 = xor i64 %xor165, %mul172
  %xor173 = xor i64 %xor169, %add161
  ret i64 %xor173
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @_Z17switch_redundancyiiiii(i32 noundef %x, i32 noundef %a, i32 noundef %b, i32 noundef %c, i32 noundef %d) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i32 %a, 1000003
  %mul1 = mul nsw i32 %b, 998244353
  %add = add nsw i32 %mul1, %mul
  %mul2 = mul nsw i32 %b, 999999937
  %mul3 = mul nsw i32 %c, 1000000007
  %add4 = add nsw i32 %mul3, %mul2
  %mul5 = mul nsw i32 %c, 1013904223
  %mul6 = mul nsw i32 %d, 1664525
  %add7 = add nsw i32 %mul6, %mul5
  %mul8 = mul nsw i32 %d, 1000003
  %mul9 = mul nsw i32 %a, 999999937
  %add10 = add nsw i32 %mul8, %mul9
  %and = and i32 %x, 7
  switch i32 %and, label %default.unreachable [
    i32 0, label %sw.bb
    i32 1, label %sw.bb20
    i32 2, label %sw.bb37
    i32 3, label %sw.bb48
    i32 4, label %sw.bb69
    i32 5, label %sw.bb81
    i32 6, label %sw.bb94
    i32 7, label %sw.default
  ]

sw.bb:                                            ; preds = %entry
  %lcm.tmp27 = add nsw i32 %a, %b
  %lcm.tmp28 = add nsw i32 %c, %d
  %lcm.tmp29 = xor i32 %add, %add4
  %conv = sext i32 %add to i64
  %conv11 = sext i32 %add4 to i64
  %mul12 = mul nsw i64 %conv11, %conv
  %mul14 = mul nsw i32 %b, %a
  %conv15 = sext i32 %mul14 to i64
  %mul16 = mul nsw i32 %d, %c
  %conv17 = sext i32 %mul16 to i64
  %add18 = add nsw i64 %conv17, %conv15
  %add19 = add nsw i64 %add18, %mul12
  br label %sw.epilog

sw.bb20:                                          ; preds = %entry
  %lcm.tmp25 = xor i32 %add, %add4
  %conv21 = sext i32 %add to i64
  %conv22 = sext i32 %add7 to i64
  %mul23 = mul nsw i64 %conv22, %conv21
  %mul25 = mul nsw i32 %b, %a
  %conv26 = sext i32 %mul25 to i64
  %mul27 = mul nsw i32 %d, %c
  %conv28 = sext i32 %mul27 to i64
  %add29 = add nsw i64 %conv28, %conv26
  %add31 = add nsw i32 %b, %a
  %conv32 = sext i32 %add31 to i64
  %add33 = add nsw i32 %d, %c
  %conv34 = sext i32 %add33 to i64
  %mul35 = mul nsw i64 %conv34, %conv32
  %add30 = add nsw i64 %add29, %mul35
  %add36 = add i64 %add30, %mul23
  br label %sw.epilog

sw.bb37:                                          ; preds = %entry
  %lcm.tmp20 = mul nsw i32 %a, %b
  %lcm.tmp21 = mul nsw i32 %c, %d
  %lcm.tmp22 = xor i32 %add, %add4
  %conv38 = sext i32 %add4 to i64
  %conv39 = sext i32 %add7 to i64
  %mul40 = mul nsw i64 %conv39, %conv38
  %add42 = add nsw i32 %b, %a
  %conv43 = sext i32 %add42 to i64
  %add44 = add nsw i32 %d, %c
  %conv45 = sext i32 %add44 to i64
  %mul46 = mul nsw i64 %conv45, %conv43
  %add47 = add nsw i64 %mul40, %mul46
  br label %sw.epilog

sw.bb48:                                          ; preds = %entry
  %lcm.tmp18 = xor i32 %add, %add4
  %conv49 = sext i32 %add to i64
  %conv50 = sext i32 %add10 to i64
  %conv53 = sext i32 %add4 to i64
  %mul51274 = add nsw i64 %conv53, %conv49
  %add56 = mul i64 %mul51274, %conv50
  %mul57 = mul nsw i32 %b, %a
  %conv58 = sext i32 %mul57 to i64
  %mul59 = mul nsw i32 %d, %c
  %conv60 = sext i32 %mul59 to i64
  %add61 = add nsw i64 %conv60, %conv58
  %add63 = add nsw i32 %b, %a
  %conv64 = sext i32 %add63 to i64
  %add65 = add nsw i32 %d, %c
  %conv66 = sext i32 %add65 to i64
  %mul67 = mul nsw i64 %conv66, %conv64
  %add62 = add nsw i64 %add61, %mul67
  %add68 = add i64 %add62, %add56
  br label %sw.epilog

sw.bb69:                                          ; preds = %entry
  %conv70 = sext i32 %add7 to i64
  %conv71 = sext i32 %add10 to i64
  %mul72 = mul nsw i64 %conv70, %conv71
  br label %for.body

for.body:                                         ; preds = %for.body.for.body_crit_edge, %sw.bb69
  %result.0276 = phi i64 [ %mul72, %sw.bb69 ], [ %add80, %for.body.for.body_crit_edge ]
  %i.0275 = phi i32 [ 0, %sw.bb69 ], [ %inc, %for.body.for.body_crit_edge ]
  %mul74 = mul nuw nsw i32 %i.0275, 1013904223
  %xor = xor i32 %mul74, %add
  %conv75 = sext i32 %xor to i64
  %mul76 = mul nuw nsw i32 %i.0275, 1664525
  %xor77 = xor i32 %mul76, %add4
  %conv78 = sext i32 %xor77 to i64
  %mul79 = mul nsw i64 %conv75, %conv78
  %add80 = add nsw i64 %mul79, %result.0276
  %inc = add nuw nsw i32 %i.0275, 1
  %exitcond.not = icmp eq i32 %inc, 4
  br i1 %exitcond.not, label %for.body.sw.epilog_crit_edge, label %for.body.for.body_crit_edge, !llvm.loop !9

for.body.for.body_crit_edge:                      ; preds = %for.body
  br label %for.body, !llvm.loop !9

for.body.sw.epilog_crit_edge:                     ; preds = %for.body
  %lcm.tmp10 = mul nsw i32 %a, %b
  %lcm.tmp11 = mul nsw i32 %c, %d
  %lcm.tmp12 = add nsw i32 %a, %b
  %lcm.tmp13 = add nsw i32 %c, %d
  %lcm.tmp14 = xor i32 %add, %add4
  br label %sw.epilog, !llvm.loop !9

sw.bb81:                                          ; preds = %entry
  %lcm.tmp7 = add nsw i32 %a, %b
  %lcm.tmp8 = add nsw i32 %c, %d
  %xor82 = xor i32 %add4, %add
  %conv83 = sext i32 %xor82 to i64
  %xor84 = xor i32 %add7, %add10
  %conv85 = sext i32 %xor84 to i64
  %mul86 = mul nsw i64 %conv85, %conv83
  %mul88 = mul nsw i32 %b, %a
  %conv89 = sext i32 %mul88 to i64
  %mul90 = mul nsw i32 %d, %c
  %conv91 = sext i32 %mul90 to i64
  %add92 = add nsw i64 %conv91, %conv89
  %add93 = add nsw i64 %add92, %mul86
  br label %sw.epilog

sw.bb94:                                          ; preds = %entry
  %lcm.tmp2 = mul nsw i32 %a, %b
  %lcm.tmp3 = mul nsw i32 %c, %d
  %lcm.tmp4 = xor i32 %add, %add4
  %add95 = add nsw i32 %add4, %add
  %conv96 = sext i32 %add95 to i64
  %add97 = add nsw i32 %add7, %add10
  %conv98 = sext i32 %add97 to i64
  %mul99 = mul nsw i64 %conv98, %conv96
  %add101 = add nsw i32 %b, %a
  %conv102 = sext i32 %add101 to i64
  %add103 = add nsw i32 %d, %c
  %conv104 = sext i32 %add103 to i64
  %mul105 = mul nsw i64 %conv104, %conv102
  %add106 = add nsw i64 %mul99, %mul105
  br label %sw.epilog

default.unreachable:                              ; preds = %entry
  unreachable

sw.default:                                       ; preds = %entry
  %lcm.tmp = xor i32 %add, %add4
  %conv107 = sext i32 %add to i64
  %conv108 = sext i32 %add4 to i64
  %mul109 = mul nsw i64 %conv108, %conv107
  %conv110 = sext i32 %add7 to i64
  %mul111 = mul nsw i64 %mul109, %conv110
  %mul113 = mul nsw i32 %b, %a
  %conv114 = sext i32 %mul113 to i64
  %mul115 = mul nsw i32 %d, %c
  %conv116 = sext i32 %mul115 to i64
  %add117 = add nsw i64 %conv116, %conv114
  %add119 = add nsw i32 %b, %a
  %conv120 = sext i32 %add119 to i64
  %add121 = add nsw i32 %d, %c
  %conv122 = sext i32 %add121 to i64
  %mul123 = mul nsw i64 %conv122, %conv120
  %add118 = add nsw i64 %add117, %mul123
  %add124 = add i64 %add118, %mul111
  br label %sw.epilog

sw.epilog:                                        ; preds = %for.body.sw.epilog_crit_edge, %sw.default, %sw.bb94, %sw.bb81, %sw.bb48, %sw.bb37, %sw.bb20, %sw.bb
  %lcm.phi35 = phi i32 [ %lcm.tmp14, %for.body.sw.epilog_crit_edge ], [ %lcm.tmp, %sw.default ], [ %lcm.tmp4, %sw.bb94 ], [ %xor82, %sw.bb81 ], [ %lcm.tmp18, %sw.bb48 ], [ %lcm.tmp22, %sw.bb37 ], [ %lcm.tmp25, %sw.bb20 ], [ %lcm.tmp29, %sw.bb ]
  %lcm.phi34 = phi i32 [ %lcm.tmp13, %for.body.sw.epilog_crit_edge ], [ %add121, %sw.default ], [ %add103, %sw.bb94 ], [ %lcm.tmp8, %sw.bb81 ], [ %add65, %sw.bb48 ], [ %add44, %sw.bb37 ], [ %add33, %sw.bb20 ], [ %lcm.tmp28, %sw.bb ]
  %lcm.phi33 = phi i32 [ %lcm.tmp12, %for.body.sw.epilog_crit_edge ], [ %add119, %sw.default ], [ %add101, %sw.bb94 ], [ %lcm.tmp7, %sw.bb81 ], [ %add63, %sw.bb48 ], [ %add42, %sw.bb37 ], [ %add31, %sw.bb20 ], [ %lcm.tmp27, %sw.bb ]
  %lcm.phi32 = phi i32 [ %lcm.tmp11, %for.body.sw.epilog_crit_edge ], [ %mul115, %sw.default ], [ %lcm.tmp3, %sw.bb94 ], [ %mul90, %sw.bb81 ], [ %mul59, %sw.bb48 ], [ %lcm.tmp21, %sw.bb37 ], [ %mul27, %sw.bb20 ], [ %mul16, %sw.bb ]
  %lcm.phi = phi i32 [ %lcm.tmp10, %for.body.sw.epilog_crit_edge ], [ %mul113, %sw.default ], [ %lcm.tmp2, %sw.bb94 ], [ %mul88, %sw.bb81 ], [ %mul57, %sw.bb48 ], [ %lcm.tmp20, %sw.bb37 ], [ %mul25, %sw.bb20 ], [ %mul14, %sw.bb ]
  %result.1 = phi i64 [ %add124, %sw.default ], [ %add19, %sw.bb ], [ %add36, %sw.bb20 ], [ %add47, %sw.bb37 ], [ %add68, %sw.bb48 ], [ %add106, %sw.bb94 ], [ %add93, %sw.bb81 ], [ %add80, %for.body.sw.epilog_crit_edge ]
  %conv126 = sext i32 %lcm.phi to i64
  %conv128 = sext i32 %lcm.phi32 to i64
  %add129 = add nsw i64 %conv128, %conv126
  %conv132 = sext i32 %lcm.phi33 to i64
  %conv134 = sext i32 %lcm.phi34 to i64
  %mul135 = mul nsw i64 %conv134, %conv132
  %add139 = add nsw i32 %lcm.phi32, %lcm.phi
  %mul142 = mul nsw i32 %lcm.phi34, %lcm.phi33
  %xor143 = xor i32 %add139, %mul142
  %conv144 = sext i32 %xor143 to i64
  %xor145 = xor i32 %b, %a
  %xor146 = xor i32 %xor145, %c
  %xor147 = xor i32 %xor146, %d
  %conv148 = sext i32 %xor147 to i64
  %mul149 = mul nsw i64 %conv144, %conv148
  %add130 = add nsw i64 %add129, %mul135
  %add136 = add i64 %add130, %mul149
  %add150 = add i64 %add136, %result.1
  %xor154278 = xor i32 %lcm.phi35, %add7
  %xor156279 = xor i32 %xor154278, %add10
  %xor156 = sext i32 %xor156279 to i64
  %xor158 = xor i64 %add150, %xor156
  ret i64 %xor158
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @_Z17interleaved_loopsiiii(i32 noundef %a, i32 noundef %b, i32 noundef %c, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i32 %b, %a
  %mul1 = mul nsw i32 %c, %b
  %mul2 = mul nsw i32 %c, %a
  %cmp218 = icmp sgt i32 %n, 0
  br i1 %cmp218, label %for.body.lr.ph, label %entry.for.cond.cleanup_crit_edge

entry.for.cond.cleanup_crit_edge:                 ; preds = %entry
  br label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %mul22 = mul nsw i32 %mul, %c
  %conv23 = sext i32 %mul22 to i64
  %add25 = add nsw i32 %b, %a
  %add26 = add nsw i32 %add25, %c
  %conv27 = sext i32 %add26 to i64
  %0 = sext i32 %mul to i64
  %1 = sext i32 %mul1 to i64
  %wide.trip.count = zext nneg i32 %n to i64
  br label %for.body

for.cond.cleanup:                                 ; preds = %if.end.for.cond.cleanup_crit_edge, %entry.for.cond.cleanup_crit_edge
  %lcm.phi = phi i1 [ %lcm.tmp3, %if.end.for.cond.cleanup_crit_edge ], [ %cmp218, %entry.for.cond.cleanup_crit_edge ]
  %carry1.0.lcssa = phi i32 [ %b, %entry.for.cond.cleanup_crit_edge ], [ %xor5, %if.end.for.cond.cleanup_crit_edge ]
  %carry2.0.lcssa = phi i32 [ %c, %entry.for.cond.cleanup_crit_edge ], [ %mul7, %if.end.for.cond.cleanup_crit_edge ]
  %carry0.0.lcssa = phi i32 [ %a, %entry.for.cond.cleanup_crit_edge ], [ %xor, %if.end.for.cond.cleanup_crit_edge ]
  %result.0.lcssa = phi i64 [ 0, %entry.for.cond.cleanup_crit_edge ], [ %result.1, %if.end.for.cond.cleanup_crit_edge ]
  %mul44 = mul nsw i32 %mul, %c
  %conv45 = sext i32 %mul44 to i64
  %add46 = add nsw i64 %result.0.lcssa, %conv45
  br i1 %lcm.phi, label %for.body54.lr.ph, label %for.cond.cleanup.for.cond.cleanup53_crit_edge

for.cond.cleanup.for.cond.cleanup53_crit_edge:    ; preds = %for.cond.cleanup
  br label %for.cond.cleanup53

for.body54.lr.ph:                                 ; preds = %for.cond.cleanup
  %xor47 = xor i32 %carry0.0.lcssa, %carry1.0.lcssa
  %xor49 = xor i32 %carry0.0.lcssa, %carry2.0.lcssa
  %xor48 = xor i32 %carry2.0.lcssa, %carry1.0.lcssa
  %add77 = add nsw i32 %b, %a
  %add78 = add nsw i32 %add77, %c
  %conv79 = sext i32 %add78 to i64
  %conv91 = sext i32 %mul to i64
  %conv96 = sext i32 %mul1 to i64
  %conv101 = sext i32 %mul2 to i64
  %2 = sext i32 %mul to i64
  %wide.trip.count248 = zext nneg i32 %n to i64
  br label %for.body54

for.body:                                         ; preds = %if.end.for.body_crit_edge, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %if.end.for.body_crit_edge ]
  %result.0223 = phi i64 [ 0, %for.body.lr.ph ], [ %result.1, %if.end.for.body_crit_edge ]
  %carry0.0222 = phi i32 [ %a, %for.body.lr.ph ], [ %xor, %if.end.for.body_crit_edge ]
  %carry2.0220 = phi i32 [ %c, %for.body.lr.ph ], [ %mul7, %if.end.for.body_crit_edge ]
  %carry1.0219 = phi i32 [ %b, %for.body.lr.ph ], [ %xor5, %if.end.for.body_crit_edge ]
  %3 = trunc i64 %indvars.iv to i32
  %4 = mul i32 %3, 1000003
  %add = add nsw i32 %4, %carry0.0222
  %xor = xor i32 %add, %carry1.0219
  %mul4 = mul nsw i32 %xor, 998244353
  %xor5 = xor i32 %mul4, %carry2.0220
  %add6 = add nsw i32 %xor5, %xor
  %mul7 = mul nsw i32 %add6, 999999937
  %and250 = and i64 %indvars.iv, 1
  %tobool.not = icmp eq i64 %and250, 0
  br i1 %tobool.not, label %if.else, label %if.then

if.then:                                          ; preds = %for.body
  %5 = add nsw i64 %indvars.iv, %0
  %add10 = add nsw i32 %xor, %c
  %conv11 = sext i32 %add10 to i64
  %mul12 = mul nsw i64 %5, %conv11
  %6 = add nsw i64 %indvars.iv, %1
  %add17 = add nsw i32 %xor5, %a
  %conv18 = sext i32 %add17 to i64
  %mul19 = mul nsw i64 %6, %conv18
  %mul28 = mul nsw i64 %indvars.iv, %conv27
  %add13 = add i64 %mul28, %conv23
  %add20 = add i64 %add13, %result.0223
  %add29 = add i64 %add20, %mul12
  %add30 = add i64 %add29, %mul19
  br label %if.end

if.else:                                          ; preds = %for.body
  %conv31 = sext i32 %xor to i64
  %conv32 = sext i32 %xor5 to i64
  %mul33 = mul nsw i64 %conv32, %conv31
  %conv36 = sext i32 %mul7 to i64
  %reass.add = add nsw i64 %conv32, %conv31
  %reass.mul = mul i64 %reass.add, %conv36
  %add38 = add i64 %mul33, %result.0223
  %add42 = add i64 %add38, %reass.mul
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %result.1 = phi i64 [ %add30, %if.then ], [ %add42, %if.else ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %if.end.for.cond.cleanup_crit_edge, label %if.end.for.body_crit_edge, !llvm.loop !12

if.end.for.body_crit_edge:                        ; preds = %if.end
  br label %for.body, !llvm.loop !12

if.end.for.cond.cleanup_crit_edge:                ; preds = %if.end
  %lcm.tmp3 = icmp sgt i32 %n, 0
  br label %for.cond.cleanup, !llvm.loop !12

for.cond.cleanup53.loopexit:                      ; preds = %if.end90
  %7 = xor i32 %xor58, %carry0.0.lcssa
  br label %for.cond.cleanup53

for.cond.cleanup53:                               ; preds = %for.cond.cleanup.for.cond.cleanup53_crit_edge, %for.cond.cleanup53.loopexit
  %carry3.0.lcssa = phi i32 [ %carry1.0.lcssa, %for.cond.cleanup.for.cond.cleanup53_crit_edge ], [ %7, %for.cond.cleanup53.loopexit ]
  %result.2.lcssa = phi i64 [ %add46, %for.cond.cleanup.for.cond.cleanup53_crit_edge ], [ %add105, %for.cond.cleanup53.loopexit ]
  %sub = add nsw i32 %n, -1
  %conv112 = sext i32 %sub to i64
  %add113 = add nsw i32 %b, %a
  %add114 = add nsw i32 %add113, %c
  %conv115 = sext i32 %add114 to i64
  %mul116 = mul nsw i64 %conv112, %conv115
  %add117 = add nsw i64 %mul116, %conv45
  %add118 = add nsw i64 %add117, %result.2.lcssa
  %xor120 = sext i32 %carry3.0.lcssa to i64
  %xor122 = xor i64 %add118, %xor120
  ret i64 %xor122

for.body54:                                       ; preds = %if.end90.for.body54_crit_edge, %for.body54.lr.ph
  %indvars.iv240 = phi i64 [ 0, %for.body54.lr.ph ], [ %indvars.iv.next241, %if.end90.for.body54_crit_edge ]
  %result.2232 = phi i64 [ %add46, %for.body54.lr.ph ], [ %add105, %if.end90.for.body54_crit_edge ]
  %carry5.0230 = phi i32 [ %xor49, %for.body54.lr.ph ], [ %mul62, %if.end90.for.body54_crit_edge ]
  %carry4.0229 = phi i32 [ %xor48, %for.body54.lr.ph ], [ %xor60, %if.end90.for.body54_crit_edge ]
  %carry3.0228 = phi i32 [ %xor47, %for.body54.lr.ph ], [ %xor58, %if.end90.for.body54_crit_edge ]
  %8 = trunc i64 %indvars.iv240 to i32
  %9 = mul i32 %8, 1664525
  %add57 = add nsw i32 %9, %carry3.0228
  %xor58 = xor i32 %add57, %carry4.0229
  %mul59 = mul nsw i32 %xor58, 1013904223
  %xor60 = xor i32 %mul59, %carry5.0230
  %add61 = add nsw i32 %xor60, %xor58
  %mul62 = mul nsw i32 %add61, 1000003
  %and63251 = and i64 %indvars.iv240, 3
  %tobool64.not = icmp eq i64 %and63251, 0
  br i1 %tobool64.not, label %if.else83, label %if.then65

if.then65:                                        ; preds = %for.body54
  %10 = add nsw i64 %indvars.iv240, %2
  %add69 = add nsw i32 %xor58, %c
  %conv70 = sext i32 %add69 to i64
  %mul71 = mul nsw i64 %10, %conv70
  %mul80 = mul nsw i64 %indvars.iv240, %conv79
  %add72 = add i64 %result.2232, %conv45
  %add81 = add i64 %add72, %mul80
  %add82 = add i64 %add81, %mul71
  br label %if.end90

if.else83:                                        ; preds = %for.body54
  %conv84 = sext i32 %xor58 to i64
  %conv85 = sext i32 %xor60 to i64
  %mul86 = mul nsw i64 %conv85, %conv84
  %conv87 = sext i32 %mul62 to i64
  %mul88 = mul nsw i64 %mul86, %conv87
  %add89 = add nsw i64 %mul88, %result.2232
  br label %if.end90

if.end90:                                         ; preds = %if.else83, %if.then65
  %result.3 = phi i64 [ %add82, %if.then65 ], [ %add89, %if.else83 ]
  %11 = sext i32 %xor58 to i64
  %12 = add nsw i64 %indvars.iv240, %11
  %mul94 = mul nsw i64 %12, %conv91
  %13 = sext i32 %xor60 to i64
  %14 = add nsw i64 %indvars.iv240, %13
  %mul99 = mul nsw i64 %14, %conv96
  %15 = sext i32 %mul62 to i64
  %16 = add nsw i64 %indvars.iv240, %15
  %mul104 = mul nsw i64 %16, %conv101
  %add95 = add i64 %mul99, %mul94
  %add100 = add i64 %add95, %mul104
  %add105 = add i64 %add100, %result.3
  %indvars.iv.next241 = add nuw nsw i64 %indvars.iv240, 1
  %exitcond249.not = icmp eq i64 %indvars.iv.next241, %wide.trip.count248
  br i1 %exitcond249.not, label %for.cond.cleanup53.loopexit, label %if.end90.for.body54_crit_edge, !llvm.loop !13

if.end90.for.body54_crit_edge:                    ; preds = %if.end90
  br label %for.body54, !llvm.loop !13
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @_Z24short_circuit_redundancyiiiiii(i32 noundef %a, i32 noundef %b, i32 noundef %c, i32 noundef %d, i32 noundef %threshold, i32 noundef %flags) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i32 %b, %a
  %mul1 = mul nsw i32 %d, %c
  %xor = xor i32 %mul1, %mul
  %and = and i32 %flags, 1
  %tobool.not = icmp ne i32 %and, 0
  %cmp = icmp sgt i32 %xor, %threshold
  %or.cond = select i1 %tobool.not, i1 %cmp, i1 false
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %conv = sext i32 %xor to i64
  %add = add nsw i32 %b, %a
  %add2 = add nsw i32 %add, %c
  %add3 = add nsw i32 %add2, %d
  %conv4 = sext i32 %add3 to i64
  %mul5 = mul nsw i64 %conv, %conv4
  br label %cleanup111

if.end:                                           ; preds = %entry
  %mul6 = mul nsw i32 %a, 1000003
  %add7 = add nsw i32 %mul6, %b
  %mul8 = mul nsw i32 %c, 998244353
  %add9 = add nsw i32 %mul8, %d
  %add16 = add nsw i32 %b, %a
  %add17 = add nsw i32 %d, %c
  %mul18 = mul nsw i32 %add17, %add16
  %and19 = and i32 %flags, 2
  %tobool20.not = icmp ne i32 %and19, 0
  %sub = sub nsw i32 0, %threshold
  %cmp22 = icmp slt i32 %mul18, %sub
  %or.cond201 = select i1 %tobool20.not, i1 %cmp22, i1 false
  br i1 %or.cond201, label %if.then23, label %if.end36

if.then23:                                        ; preds = %if.end
  %conv24 = sext i32 %add7 to i64
  %conv25 = sext i32 %add9 to i64
  %mul26 = mul nsw i64 %conv25, %conv24
  %xor32 = sext i32 %xor to i64
  %add33 = add nsw i64 %mul26, %xor32
  %conv34 = sext i32 %mul18 to i64
  %mul35 = mul nsw i64 %add33, %conv34
  br label %cleanup111

if.end36:                                         ; preds = %if.end
  %add13 = add nsw i32 %c, %a
  %add14 = add nsw i32 %d, %b
  %mul15 = mul nsw i32 %add14, %add13
  %xor10 = xor i32 %b, %a
  %xor11 = xor i32 %d, %c
  %mul12 = mul nsw i32 %xor11, %xor10
  %mul37 = mul nsw i32 %mul12, %add7
  %mul38 = mul nsw i32 %mul15, %add9
  %xor39 = xor i32 %add9, %add7
  %xor40 = xor i32 %mul12, %mul15
  %mul41 = mul nsw i32 %xor40, %xor39
  %add42 = add nsw i32 %mul12, %add7
  %add43 = add nsw i32 %mul15, %add9
  %mul44 = mul nsw i32 %add42, %add43
  %and45 = and i32 %flags, 4
  %tobool46.not = icmp eq i32 %and45, 0
  br i1 %tobool46.not, label %if.else, label %if.then47

if.then47:                                        ; preds = %if.end36
  %conv48 = sext i32 %mul37 to i64
  %conv49 = sext i32 %mul38 to i64
  %mul50 = mul nsw i64 %conv48, %conv49
  %conv52 = sext i32 %mul41 to i64
  %conv53 = sext i32 %mul44 to i64
  %mul54 = mul nsw i64 %conv52, %conv53
  %add55 = add nsw i64 %mul54, %mul50
  br label %if.end74

if.else:                                          ; preds = %if.end36
  %xor56 = xor i32 %mul41, %mul37
  %conv57 = sext i32 %xor56 to i64
  %xor58 = xor i32 %mul44, %mul38
  %conv59 = sext i32 %xor58 to i64
  %mul60 = mul nsw i64 %conv57, %conv59
  %xor66 = sext i32 %xor to i64
  %conv69 = sext i32 %add16 to i64
  %conv71 = sext i32 %add17 to i64
  %mul72 = mul nsw i64 %conv71, %conv69
  %add67 = add nsw i64 %mul72, %xor66
  %add73 = add i64 %add67, %mul60
  br label %if.end74

if.end74:                                         ; preds = %if.else, %if.then47
  %result.0 = phi i64 [ %add55, %if.then47 ], [ %add73, %if.else ]
  %conv78 = sext i32 %xor to i64
  %conv81 = sext i32 %add16 to i64
  %conv83 = sext i32 %add17 to i64
  %mul84 = mul nsw i64 %conv83, %conv81
  %mul92 = mul nsw i32 %xor, %mul18
  %conv93 = sext i32 %mul92 to i64
  %xor94 = xor i32 %xor, %mul18
  %conv95 = sext i32 %xor94 to i64
  %conv98 = sext i32 %mul37 to i64
  %mul101 = mul nsw i64 %conv98, %conv93
  %add79 = add nsw i64 %mul84, %conv78
  %add85 = add nsw i64 %add79, %conv95
  %add96 = add nsw i64 %add85, %conv93
  %add97 = add i64 %add96, %mul101
  %add102 = add i64 %add97, %result.0
  %xor104202 = xor i32 %mul41, %add7
  %xor104 = sext i32 %xor104202 to i64
  %xor106 = xor i64 %add102, %xor104
  br label %cleanup111

cleanup111:                                       ; preds = %if.end74, %if.then23, %if.then
  %retval.1 = phi i64 [ %mul5, %if.then ], [ %mul35, %if.then23 ], [ %xor106, %if.end74 ]
  ret i64 %retval.1
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @_Z17matrix_redundancyiiiiiiiiiiiibb(i32 noundef %m00, i32 noundef %m01, i32 noundef %m02, i32 noundef %m03, i32 noundef %m10, i32 noundef %m11, i32 noundef %m12, i32 noundef %m13, i32 noundef %m20, i32 noundef %m21, i32 noundef %m22, i32 noundef %m23, i1 noundef zeroext %process_row1, i1 noundef zeroext %process_row2) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i32 %m11, %m00
  %mul2 = mul nsw i32 %m10, %m01
  %sub = sub nsw i32 %mul, %mul2
  %mul3 = mul nsw i32 %m12, %m00
  %mul4 = mul nsw i32 %m10, %m02
  %sub5 = sub nsw i32 %mul3, %mul4
  %mul6 = mul nsw i32 %m13, %m00
  %mul7 = mul nsw i32 %m10, %m03
  %sub8 = sub nsw i32 %mul6, %mul7
  %mul9 = mul nsw i32 %m12, %m01
  %mul10 = mul nsw i32 %m11, %m02
  %sub11 = sub nsw i32 %mul9, %mul10
  %mul12 = mul nsw i32 %m13, %m01
  %mul13 = mul nsw i32 %m11, %m03
  %sub14 = sub nsw i32 %mul12, %mul13
  %mul15 = mul nsw i32 %m13, %m02
  %mul16 = mul nsw i32 %m12, %m03
  %sub17 = sub nsw i32 %mul15, %mul16
  %conv = sext i32 %sub to i64
  %conv18 = sext i32 %sub17 to i64
  %mul19 = mul nsw i64 %conv18, %conv
  %conv20 = sext i32 %sub5 to i64
  %conv21 = sext i32 %sub14 to i64
  %mul22 = mul nsw i64 %conv21, %conv20
  %sub23 = sub nsw i64 %mul19, %mul22
  %conv24 = sext i32 %sub8 to i64
  %conv25 = sext i32 %sub11 to i64
  %mul26 = mul nsw i64 %conv24, %conv25
  %add = add nsw i64 %sub23, %mul26
  br i1 %process_row1, label %if.then, label %entry.if.end_crit_edge

entry.if.end_crit_edge:                           ; preds = %entry
  br label %if.end

if.then:                                          ; preds = %entry
  %mul38 = mul nsw i32 %m21, %m10
  %mul39 = mul nsw i32 %m20, %m11
  %sub40 = sub nsw i32 %mul38, %mul39
  %mul41 = mul nsw i32 %m22, %m10
  %mul42 = mul nsw i32 %m20, %m12
  %sub43 = sub nsw i32 %mul41, %mul42
  %mul44 = mul nsw i32 %m23, %m10
  %mul45 = mul nsw i32 %m20, %m13
  %sub46 = sub nsw i32 %mul44, %mul45
  %mul47 = mul nsw i32 %m22, %m11
  %mul48 = mul nsw i32 %m21, %m12
  %sub49 = sub nsw i32 %mul47, %mul48
  %mul50 = mul nsw i32 %m23, %m11
  %mul51 = mul nsw i32 %m21, %m13
  %sub52 = sub nsw i32 %mul50, %mul51
  %mul53 = mul nsw i32 %m23, %m12
  %mul54 = mul nsw i32 %m22, %m13
  %sub55 = sub nsw i32 %mul53, %mul54
  %conv57 = sext i32 %sub55 to i64
  %conv59 = sext i32 %sub40 to i64
  %conv60 = sext i32 %sub52 to i64
  %conv63 = sext i32 %sub43 to i64
  %conv64 = sext i32 %sub49 to i64
  %conv68 = sext i32 %sub46 to i64
  %sub69 = sub nsw i32 %sub49, %sub52
  %conv70 = sext i32 %sub69 to i64
  %conv74 = sext i32 %mul3 to i64
  %conv79 = sext i32 %mul6 to i64
  %conv84 = sext i32 %mul47 to i64
  %conv89 = sext i32 %mul53 to i64
  %reass.add = add nsw i64 %conv70, %conv84
  %reass.mul = mul i64 %reass.add, %conv68
  %reass.add324 = add nsw i64 %conv57, %conv89
  %reass.mul325 = mul i64 %reass.add324, %conv
  %reass.add326 = add nsw i64 %conv64, %conv79
  %reass.mul327 = mul i64 %reass.add326, %conv63
  %reass.add328 = sub nsw i64 %conv74, %conv60
  %reass.mul329 = mul nsw i64 %reass.add328, %conv59
  %add77 = add i64 %reass.mul327, %add
  %add82 = add i64 %add77, %reass.mul325
  %add87 = add i64 %add82, %reass.mul
  %add92 = add i64 %add87, %reass.mul329
  br label %if.end

if.end:                                           ; preds = %entry.if.end_crit_edge, %if.then
  %result.0 = phi i64 [ %add92, %if.then ], [ %add, %entry.if.end_crit_edge ]
  br i1 %process_row2, label %if.then94, label %if.end.if.end145_crit_edge

if.end.if.end145_crit_edge:                       ; preds = %if.end
  %lcm.tmp3 = mul nsw i32 %m11, %m22
  %lcm.tmp4 = mul nsw i32 %m11, %m23
  %lcm.tmp5 = mul nsw i32 %m12, %m23
  br label %if.end145

if.then94:                                        ; preds = %if.end
  %mul98 = mul nsw i32 %m22, %m00
  %mul99 = mul nsw i32 %m20, %m02
  %sub100 = sub nsw i32 %mul98, %mul99
  %mul101 = mul nsw i32 %m23, %m00
  %mul102 = mul nsw i32 %m20, %m03
  %sub103 = sub nsw i32 %mul101, %mul102
  %mul104 = mul nsw i32 %m22, %m11
  %mul105 = mul nsw i32 %m21, %m12
  %sub106 = sub nsw i32 %mul104, %mul105
  %mul107 = mul nsw i32 %m23, %m11
  %mul108 = mul nsw i32 %m21, %m13
  %sub109 = sub nsw i32 %mul107, %mul108
  %mul110 = mul nsw i32 %m23, %m12
  %mul111 = mul nsw i32 %m22, %m13
  %sub112 = sub nsw i32 %mul110, %mul111
  %conv114 = sext i32 %sub112 to i64
  %conv116 = sext i32 %sub100 to i64
  %conv117 = sext i32 %sub109 to i64
  %conv120 = sext i32 %sub103 to i64
  %conv121 = sext i32 %sub106 to i64
  %conv126 = sext i32 %mul to i64
  %conv131 = sext i32 %mul3 to i64
  %conv136 = sext i32 %mul104 to i64
  %conv141 = sext i32 %mul110 to i64
  %mul143 = mul nsw i64 %conv141, %conv116
  %reass.add330 = add nsw i64 %conv121, %conv136
  %reass.mul331 = mul i64 %reass.add330, %conv120
  %reass.add332 = add nsw i64 %conv, %conv126
  %reass.mul333 = mul i64 %reass.add332, %conv114
  %reass.add334 = sub nsw i64 %conv131, %conv116
  %reass.mul335 = mul nsw i64 %reass.add334, %conv117
  %add129 = add i64 %reass.mul331, %mul143
  %add134 = add i64 %add129, %reass.mul333
  %add139 = add i64 %add134, %result.0
  %add144 = add i64 %add139, %reass.mul335
  br label %if.end145

if.end145:                                        ; preds = %if.end.if.end145_crit_edge, %if.then94
  %lcm.phi7 = phi i32 [ %lcm.tmp5, %if.end.if.end145_crit_edge ], [ %mul110, %if.then94 ]
  %lcm.phi6 = phi i32 [ %lcm.tmp4, %if.end.if.end145_crit_edge ], [ %mul107, %if.then94 ]
  %lcm.phi = phi i32 [ %lcm.tmp3, %if.end.if.end145_crit_edge ], [ %mul104, %if.then94 ]
  %result.1 = phi i64 [ %add144, %if.then94 ], [ %result.0, %if.end.if.end145_crit_edge ]
  %conv147 = sext i32 %mul to i64
  %conv149 = sext i32 %lcm.phi7 to i64
  %conv153 = sext i32 %mul3 to i64
  %conv155 = sext i32 %lcm.phi to i64
  %mul156 = mul nsw i64 %conv155, %conv153
  %conv159 = sext i32 %mul6 to i64
  %conv161 = sext i32 %lcm.phi6 to i64
  %mul162 = mul nsw i64 %conv161, %conv159
  %mul172 = mul nsw i64 %conv20, %conv
  %mul174 = mul nsw i64 %mul172, %conv24
  %mul178 = mul nsw i64 %conv21, %conv25
  %mul180 = mul nsw i64 %mul178, %conv18
  %reass.add336 = add nsw i64 %conv155, %conv147
  %reass.mul337 = mul i64 %reass.add336, %conv149
  %add157 = add i64 %mul180, %mul174
  %add163 = add i64 %add157, %mul156
  %add169 = add i64 %add163, %mul162
  %add175 = add i64 %add169, %reass.mul337
  %add181 = add i64 %add175, %result.1
  ret i64 %add181
}

; Function Attrs: mustprogress norecurse nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %argc, ptr noundef readonly captures(none) %argv) local_unnamed_addr #1 {
entry:
  %cmp = icmp sgt i32 %argc, 1
  br i1 %cmp, label %cond.true, label %entry.cond.end_crit_edge

entry.cond.end_crit_edge:                         ; preds = %entry
  br label %cond.end

cond.true:                                        ; preds = %entry
  %arrayidx = getelementptr inbounds nuw i8, ptr %argv, i64 8
  %0 = load ptr, ptr %arrayidx, align 8, !tbaa !14
  %call.i = tail call i64 @__isoc23_strtol(ptr noundef nonnull %0, ptr noundef null, i32 noundef 10) #4
  %conv.i = trunc i64 %call.i to i32
  br label %cond.end

cond.end:                                         ; preds = %entry.cond.end_crit_edge, %cond.true
  %cond = phi i32 [ %conv.i, %cond.true ], [ 12345, %entry.cond.end_crit_edge ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %call70 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %add69)
  store volatile i64 %add69, ptr @_ZL11global_sink, align 8, !tbaa !17
  ret i32 0

for.body:                                         ; preds = %for.body.for.body_crit_edge, %cond.end
  %sink.0131 = phi i64 [ 0, %cond.end ], [ %add69, %for.body.for.body_crit_edge ]
  %i.0130 = phi i32 [ 0, %cond.end ], [ %inc, %for.body.for.body_crit_edge ]
  %mul = mul nsw i32 %i.0130, %cond
  %mul2 = mul i32 %mul, 579
  %shr = lshr i32 %mul2, 3
  %and = and i32 %shr, 2047
  %shr5 = lshr i32 %mul, 5
  %and6 = and i32 %shr5, 2047
  %mul8 = mul i32 %mul, 182721
  %shr9 = lshr i32 %mul8, 7
  %and10 = and i32 %shr9, 2047
  %mul12 = mul i32 %mul, 615949
  %shr13 = lshr i32 %mul12, 9
  %and14 = and i32 %shr13, 2047
  %xor = xor i32 %shr5, %cond
  %xor15 = xor i32 %xor, %shr
  %mul16 = mul i32 %xor15, 863
  %and17 = and i32 %mul16, 2047
  %xor18 = xor i32 %shr5, %cond
  %xor19 = xor i32 %xor18, %shr9
  %mul20 = mul i32 %xor19, 579
  %and21 = and i32 %mul20, 2047
  %xor22 = xor i32 %shr13, %cond
  %xor23 = xor i32 %xor22, %shr9
  %and25 = and i32 %xor23, 2047
  %xor26 = xor i32 %shr, %cond
  %xor27 = xor i32 %xor26, %shr13
  %mul28 = mul i32 %xor27, 449
  %and29 = and i32 %mul28, 2047
  %and30 = and i32 %i.0130, 1
  %cmp31 = icmp ne i32 %and30, 0
  %and32 = and i32 %i.0130, 2
  %cmp33 = icmp ne i32 %and32, 0
  %and35 = and i32 %i.0130, 4
  %cmp36 = icmp ne i32 %and35, 0
  %and38 = and i32 %i.0130, 8
  %cmp39 = icmp ne i32 %and38, 0
  %and41 = and i32 %i.0130, 16
  %cmp42 = icmp ne i32 %and41, 0
  %and44 = and i32 %i.0130, 32
  %cmp45 = icmp ne i32 %and44, 0
  %and47 = and i32 %i.0130, 7
  %add = add nuw nsw i32 %and47, 1
  %mul48 = mul nuw nsw i32 %and, %and6
  %and49 = and i32 %mul48, 65535
  %call54 = tail call noundef i64 @_Z18cascading_diamondsiiibbbb(i32 noundef %and, i32 noundef %and6, i32 noundef %and10, i1 noundef zeroext %cmp31, i1 noundef zeroext %cmp33, i1 noundef zeroext %cmp36, i1 noundef zeroext %cmp39)
  %add55 = add nsw i64 %call54, %sink.0131
  %call56 = tail call noundef i64 @_Z17switch_redundancyiiiii(i32 noundef %i.0130, i32 noundef %and, i32 noundef %and6, i32 noundef %and10, i32 noundef %and14)
  %add57 = add nsw i64 %add55, %call56
  %call58 = tail call noundef i64 @_Z17interleaved_loopsiiii(i32 noundef %and, i32 noundef %and6, i32 noundef %and10, i32 noundef %add)
  %add59 = add nsw i64 %add57, %call58
  %call60 = tail call noundef i64 @_Z24short_circuit_redundancyiiiiii(i32 noundef %and, i32 noundef %and6, i32 noundef %and10, i32 noundef %and14, i32 noundef %and49, i32 noundef %and47)
  %add61 = add nsw i64 %add59, %call60
  %add62 = add nuw nsw i32 %and10, %and6
  %add63 = add nuw nsw i32 %and10, %and14
  %add64 = add nuw nsw i32 %and17, %and14
  %add65 = add nuw nsw i32 %and17, %and21
  %call68 = tail call noundef i64 @_Z17matrix_redundancyiiiiiiiiiiiibb(i32 noundef %and, i32 noundef %and6, i32 noundef %and10, i32 noundef %and14, i32 noundef %and17, i32 noundef %and21, i32 noundef %and25, i32 noundef %and29, i32 noundef %add62, i32 noundef %add63, i32 noundef %add64, i32 noundef %add65, i1 noundef zeroext %cmp42, i1 noundef zeroext %cmp45)
  %add69 = add nsw i64 %add61, %call68
  %inc = add nuw nsw i32 %i.0130, 1
  %exitcond.not = icmp eq i32 %inc, 5000000
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body.for.body_crit_edge, !llvm.loop !19

for.body.for.body_crit_edge:                      ; preds = %for.body
  br label %for.body, !llvm.loop !19
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #2

; Function Attrs: nounwind
declare i64 @__isoc23_strtol(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #3

attributes #0 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress norecurse nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

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
!9 = distinct !{!9, !10, !11}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.unroll.disable"}
!12 = distinct !{!12, !10, !11}
!13 = distinct !{!13, !10, !11}
!14 = !{!15, !15, i64 0}
!15 = !{!"p1 omnipotent char", !16, i64 0}
!16 = !{!"any pointer", !7, i64 0}
!17 = !{!18, !18, i64 0}
!18 = !{!"long", !7, i64 0}
!19 = distinct !{!19, !10, !11}
