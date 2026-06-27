; ModuleID = 'benchmarks/register_pressure.cpp'
source_filename = "benchmarks/register_pressure.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"Result: %lld\0A\00", align 1

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @_Z23heavy_register_pressureiiiiiiiiiiiiiiiib(i32 noundef %a, i32 noundef %b, i32 noundef %c, i32 noundef %d, i32 noundef %e, i32 noundef %f, i32 noundef %g, i32 noundef %h, i32 noundef %i, i32 noundef %j, i32 noundef %k, i32 noundef %l, i32 noundef %m, i32 noundef %n, i32 noundef %o, i32 noundef %p, i1 noundef zeroext %cond) local_unnamed_addr #0 {
entry:
  %xor = xor i32 %b, %a
  %xor1 = xor i32 %c, %b
  %xor2 = xor i32 %d, %c
  %xor3 = xor i32 %e, %d
  %xor4 = xor i32 %f, %e
  %xor5 = xor i32 %g, %f
  %xor6 = xor i32 %h, %g
  %xor7 = xor i32 %i, %h
  %xor8 = xor i32 %j, %i
  %xor9 = xor i32 %k, %j
  %xor10 = xor i32 %l, %k
  %xor11 = xor i32 %m, %l
  %xor12 = xor i32 %n, %m
  %xor13 = xor i32 %o, %n
  %xor14 = xor i32 %p, %o
  %xor15 = xor i32 %p, %a
  br i1 %cond, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %conv = sext i32 %xor to i64
  %conv16 = sext i32 %xor1 to i64
  %mul = mul nsw i64 %conv16, %conv
  %conv17 = sext i32 %xor2 to i64
  %conv18 = sext i32 %xor3 to i64
  %mul19 = mul nsw i64 %conv18, %conv17
  %conv21 = sext i32 %xor4 to i64
  %conv22 = sext i32 %xor5 to i64
  %mul23 = mul nsw i64 %conv22, %conv21
  %conv25 = sext i32 %xor6 to i64
  %conv26 = sext i32 %xor7 to i64
  %mul27 = mul nsw i64 %conv26, %conv25
  %conv29 = sext i32 %xor8 to i64
  %conv30 = sext i32 %xor9 to i64
  %mul31 = mul nsw i64 %conv30, %conv29
  %conv33 = sext i32 %xor10 to i64
  %conv34 = sext i32 %xor11 to i64
  %mul35 = mul nsw i64 %conv34, %conv33
  %conv37 = sext i32 %xor12 to i64
  %conv38 = sext i32 %xor13 to i64
  %mul39 = mul nsw i64 %conv38, %conv37
  %conv41 = sext i32 %xor14 to i64
  %conv42 = sext i32 %xor15 to i64
  %mul43 = mul nsw i64 %conv41, %conv42
  %conv45 = sext i32 %a to i64
  %conv46 = sext i32 %e to i64
  %mul47 = mul nsw i64 %conv46, %conv45
  %conv48 = sext i32 %b to i64
  %conv49 = sext i32 %f to i64
  %mul50 = mul nsw i64 %conv49, %conv48
  %conv53 = sext i32 %c to i64
  %conv54 = sext i32 %g to i64
  %mul55 = mul nsw i64 %conv54, %conv53
  %conv56 = sext i32 %d to i64
  %conv57 = sext i32 %h to i64
  %mul58 = mul nsw i64 %conv57, %conv56
  %conv61 = sext i32 %i to i64
  %conv62 = sext i32 %m to i64
  %mul63 = mul nsw i64 %conv62, %conv61
  %conv64 = sext i32 %j to i64
  %conv65 = sext i32 %n to i64
  %mul66 = mul nsw i64 %conv65, %conv64
  %conv69 = sext i32 %k to i64
  %conv70 = sext i32 %o to i64
  %mul71 = mul nsw i64 %conv70, %conv69
  %conv72 = sext i32 %l to i64
  %conv73 = sext i32 %p to i64
  %mul74 = mul nsw i64 %conv73, %conv72
  %add20 = add i64 %mul47, %mul
  %add24 = add i64 %add20, %mul50
  %add28 = add i64 %add24, %mul19
  %add32 = add i64 %add28, %mul55
  %add36 = add i64 %add32, %mul58
  %add40 = add i64 %add36, %mul23
  %add44 = add i64 %add40, %mul27
  %add51 = add i64 %add44, %mul31
  %add52 = add i64 %add51, %mul63
  %add59 = add i64 %add52, %mul66
  %add60 = add i64 %add59, %mul35
  %add67 = add i64 %add60, %mul71
  %add68 = add i64 %add67, %mul74
  %add75 = add i64 %add68, %mul39
  %add76 = add i64 %add75, %mul43
  %.pre = mul nsw i32 %b, %a
  %.pre359 = sext i32 %.pre to i64
  %.pre360 = mul nsw i32 %d, %c
  %.pre361 = sext i32 %.pre360 to i64
  %.pre378 = add nsw i64 %conv48, %conv45
  br label %if.end

if.else:                                          ; preds = %entry
  %xor79351 = xor i32 %xor8, %xor
  %xor79 = sext i32 %xor79351 to i64
  %xor83352 = xor i32 %xor9, %xor1
  %xor83 = sext i32 %xor83352 to i64
  %xor87353 = xor i32 %xor10, %xor2
  %xor87 = sext i32 %xor87353 to i64
  %xor91354 = xor i32 %xor11, %xor3
  %xor91 = sext i32 %xor91354 to i64
  %xor95355 = xor i32 %xor12, %xor4
  %xor95 = sext i32 %xor95355 to i64
  %xor99356 = xor i32 %xor13, %xor5
  %xor99 = sext i32 %xor99356 to i64
  %xor103357 = xor i32 %xor14, %xor6
  %xor103 = sext i32 %xor103357 to i64
  %xor107358 = xor i32 %xor15, %xor7
  %xor107 = sext i32 %xor107358 to i64
  %conv109 = sext i32 %a to i64
  %conv110 = sext i32 %b to i64
  %conv112 = sext i32 %c to i64
  %conv114 = sext i32 %d to i64
  %conv117 = sext i32 %e to i64
  %conv118 = sext i32 %f to i64
  %conv120 = sext i32 %g to i64
  %conv122 = sext i32 %h to i64
  %conv125 = sext i32 %i to i64
  %conv126 = sext i32 %j to i64
  %conv128 = sext i32 %k to i64
  %conv130 = sext i32 %l to i64
  %conv133 = sext i32 %m to i64
  %conv134 = sext i32 %n to i64
  %conv136 = sext i32 %o to i64
  %conv138 = sext i32 %p to i64
  %mul141 = mul nsw i32 %b, %a
  %conv142 = sext i32 %mul141 to i64
  %mul143 = mul nsw i32 %d, %c
  %conv144 = sext i32 %mul143 to i64
  %add84 = add nsw i64 %conv110, %conv109
  %add88 = add nsw i64 %add84, %conv142
  %add92 = add nsw i64 %add88, %conv112
  %add96 = add nsw i64 %add92, %conv114
  %add100 = add nsw i64 %add96, %conv144
  %add104 = add nsw i64 %add100, %conv117
  %add108 = add nsw i64 %add104, %conv118
  %add111 = add nsw i64 %add108, %conv120
  %add113 = add nsw i64 %add111, %conv122
  %add115 = add nsw i64 %add113, %conv125
  %add116 = add nsw i64 %add115, %conv126
  %add119 = add nsw i64 %add116, %conv128
  %add121 = add nsw i64 %add119, %conv130
  %add123 = add nsw i64 %add121, %xor79
  %add124 = add nsw i64 %add123, %conv133
  %add127 = add nsw i64 %add124, %xor83
  %add129 = add nsw i64 %add127, %conv134
  %add131 = add nsw i64 %add129, %xor87
  %add132 = add nsw i64 %add131, %conv136
  %add135 = add nsw i64 %add132, %xor91
  %add137 = add nsw i64 %add135, %conv138
  %add139 = add nsw i64 %add137, %xor95
  %add140 = add nsw i64 %add139, %xor99
  %add145 = add nsw i64 %add140, %xor103
  %add146 = add nsw i64 %add145, %xor107
  %.pre362 = sext i32 %xor to i64
  %.pre363 = sext i32 %xor1 to i64
  %.pre364 = sext i32 %xor2 to i64
  %.pre365 = sext i32 %xor3 to i64
  %.pre366 = sext i32 %xor4 to i64
  %.pre367 = sext i32 %xor5 to i64
  %.pre368 = sext i32 %xor6 to i64
  %.pre369 = sext i32 %xor7 to i64
  %.pre370 = sext i32 %xor8 to i64
  %.pre371 = sext i32 %xor9 to i64
  %.pre372 = sext i32 %xor10 to i64
  %.pre373 = sext i32 %xor11 to i64
  %.pre374 = sext i32 %xor12 to i64
  %.pre375 = sext i32 %xor13 to i64
  %.pre376 = sext i32 %xor14 to i64
  %.pre377 = sext i32 %xor15 to i64
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %add151.pre-phi = phi i64 [ %add84, %if.else ], [ %.pre378, %if.then ]
  %conv214.pre-phi = phi i64 [ %conv138, %if.else ], [ %conv73, %if.then ]
  %conv212.pre-phi = phi i64 [ %conv136, %if.else ], [ %conv70, %if.then ]
  %conv210.pre-phi = phi i64 [ %conv134, %if.else ], [ %conv65, %if.then ]
  %conv208.pre-phi = phi i64 [ %conv133, %if.else ], [ %conv62, %if.then ]
  %conv206.pre-phi = phi i64 [ %conv130, %if.else ], [ %conv72, %if.then ]
  %conv204.pre-phi = phi i64 [ %conv128, %if.else ], [ %conv69, %if.then ]
  %conv202.pre-phi = phi i64 [ %conv126, %if.else ], [ %conv64, %if.then ]
  %conv201.pre-phi = phi i64 [ %conv125, %if.else ], [ %conv61, %if.then ]
  %conv198.pre-phi = phi i64 [ %conv122, %if.else ], [ %conv57, %if.then ]
  %conv196.pre-phi = phi i64 [ %conv120, %if.else ], [ %conv54, %if.then ]
  %conv194.pre-phi = phi i64 [ %conv118, %if.else ], [ %conv49, %if.then ]
  %conv192.pre-phi = phi i64 [ %conv117, %if.else ], [ %conv46, %if.then ]
  %conv190.pre-phi = phi i64 [ %conv114, %if.else ], [ %conv56, %if.then ]
  %conv188.pre-phi = phi i64 [ %conv112, %if.else ], [ %conv53, %if.then ]
  %conv182.pre-phi = phi i64 [ %.pre377, %if.else ], [ %conv42, %if.then ]
  %conv180.pre-phi = phi i64 [ %.pre376, %if.else ], [ %conv41, %if.then ]
  %conv178.pre-phi = phi i64 [ %.pre375, %if.else ], [ %conv38, %if.then ]
  %conv176.pre-phi = phi i64 [ %.pre374, %if.else ], [ %conv37, %if.then ]
  %conv174.pre-phi = phi i64 [ %.pre373, %if.else ], [ %conv34, %if.then ]
  %conv172.pre-phi = phi i64 [ %.pre372, %if.else ], [ %conv33, %if.then ]
  %conv170.pre-phi = phi i64 [ %.pre371, %if.else ], [ %conv30, %if.then ]
  %conv169.pre-phi = phi i64 [ %.pre370, %if.else ], [ %conv29, %if.then ]
  %conv166.pre-phi = phi i64 [ %.pre369, %if.else ], [ %conv26, %if.then ]
  %conv164.pre-phi = phi i64 [ %.pre368, %if.else ], [ %conv25, %if.then ]
  %conv162.pre-phi = phi i64 [ %.pre367, %if.else ], [ %conv22, %if.then ]
  %conv160.pre-phi = phi i64 [ %.pre366, %if.else ], [ %conv21, %if.then ]
  %conv158.pre-phi = phi i64 [ %.pre365, %if.else ], [ %conv18, %if.then ]
  %conv156.pre-phi = phi i64 [ %.pre364, %if.else ], [ %conv17, %if.then ]
  %conv154.pre-phi = phi i64 [ %.pre363, %if.else ], [ %conv16, %if.then ]
  %conv153.pre-phi = phi i64 [ %.pre362, %if.else ], [ %conv, %if.then ]
  %conv150.pre-phi = phi i64 [ %conv144, %if.else ], [ %.pre361, %if.then ]
  %conv148.pre-phi = phi i64 [ %conv142, %if.else ], [ %.pre359, %if.then ]
  %acc.0 = phi i64 [ %add146, %if.else ], [ %add76, %if.then ]
  %add152 = add nsw i64 %add151.pre-phi, %conv188.pre-phi
  %add155 = add nsw i64 %add152, %conv153.pre-phi
  %add157 = add nsw i64 %add155, %conv148.pre-phi
  %add159 = add nsw i64 %add157, %conv190.pre-phi
  %add161 = add nsw i64 %add159, %conv154.pre-phi
  %add163 = add nsw i64 %add161, %conv192.pre-phi
  %add165 = add nsw i64 %add163, %conv156.pre-phi
  %add167 = add nsw i64 %add165, %conv150.pre-phi
  %add168 = add nsw i64 %add167, %conv194.pre-phi
  %add171 = add nsw i64 %add168, %conv158.pre-phi
  %add173 = add nsw i64 %add171, %conv196.pre-phi
  %add175 = add nsw i64 %add173, %conv160.pre-phi
  %add177 = add nsw i64 %add175, %conv198.pre-phi
  %add179 = add nsw i64 %add177, %conv162.pre-phi
  %add181 = add nsw i64 %add179, %conv201.pre-phi
  %add183 = add nsw i64 %add181, %conv164.pre-phi
  %add184 = add nsw i64 %add183, %conv202.pre-phi
  %add187 = add nsw i64 %add184, %conv166.pre-phi
  %add189 = add nsw i64 %add187, %conv204.pre-phi
  %add191 = add nsw i64 %add189, %conv169.pre-phi
  %add193 = add nsw i64 %add191, %conv206.pre-phi
  %add195 = add nsw i64 %add193, %conv170.pre-phi
  %add197 = add nsw i64 %add195, %conv208.pre-phi
  %add199 = add nsw i64 %add197, %conv172.pre-phi
  %add200 = add nsw i64 %add199, %conv210.pre-phi
  %add203 = add nsw i64 %add200, %conv174.pre-phi
  %add205 = add nsw i64 %add203, %conv212.pre-phi
  %add207 = add nsw i64 %add205, %conv176.pre-phi
  %add209 = add nsw i64 %add207, %conv214.pre-phi
  %add211 = add nsw i64 %add209, %conv178.pre-phi
  %add213 = add nsw i64 %add211, %conv180.pre-phi
  %add215 = add nsw i64 %add213, %conv182.pre-phi
  %add216 = add i64 %add215, %acc.0
  ret i64 %add216
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i64 @_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii(i32 noundef %a, i32 noundef %b, i32 noundef %c, i32 noundef %d, i32 noundef %e, i32 noundef %f, i32 noundef %g, i32 noundef %h, i32 noundef %i, i32 noundef %j, i32 noundef %k, i32 noundef %l, i32 noundef %m, i32 noundef %n, i32 noundef %o, i32 noundef %p, i32 noundef %selector) local_unnamed_addr #0 {
entry:
  %xor = xor i32 %b, %a
  %xor1 = xor i32 %xor, %c
  %xor2 = xor i32 %c, %b
  %xor3 = xor i32 %xor2, %d
  %xor4 = xor i32 %d, %c
  %xor5 = xor i32 %xor4, %e
  %xor6 = xor i32 %e, %d
  %xor7 = xor i32 %xor6, %f
  %xor8 = xor i32 %f, %e
  %xor9 = xor i32 %xor8, %g
  %xor10 = xor i32 %g, %f
  %xor11 = xor i32 %xor10, %h
  %xor12 = xor i32 %h, %g
  %xor13 = xor i32 %xor12, %i
  %xor14 = xor i32 %i, %h
  %xor15 = xor i32 %xor14, %j
  %xor16 = xor i32 %j, %i
  %xor17 = xor i32 %xor16, %k
  %xor18 = xor i32 %k, %j
  %xor19 = xor i32 %xor18, %l
  %xor20 = xor i32 %l, %k
  %xor21 = xor i32 %xor20, %m
  %xor22 = xor i32 %m, %l
  %xor23 = xor i32 %xor22, %n
  %xor24 = xor i32 %n, %m
  %xor25 = xor i32 %xor24, %o
  %xor26 = xor i32 %o, %n
  %xor27 = xor i32 %xor26, %p
  %xor28 = xor i32 %p, %a
  %xor29 = xor i32 %xor28, %o
  %xor31 = xor i32 %xor, %p
  switch i32 %selector, label %if.else85 [
    i32 0, label %if.then
    i32 1, label %if.then62
  ]

if.then:                                          ; preds = %entry
  %conv = sext i32 %xor1 to i64
  %conv32 = sext i32 %xor31 to i64
  %mul = mul nsw i64 %conv32, %conv
  %conv33 = sext i32 %xor3 to i64
  %conv34 = sext i32 %xor29 to i64
  %mul35 = mul nsw i64 %conv34, %conv33
  %conv37 = sext i32 %xor5 to i64
  %conv38 = sext i32 %xor27 to i64
  %mul39 = mul nsw i64 %conv38, %conv37
  %conv40 = sext i32 %xor7 to i64
  %conv41 = sext i32 %xor25 to i64
  %mul42 = mul nsw i64 %conv41, %conv40
  %conv45 = sext i32 %xor9 to i64
  %conv46 = sext i32 %xor23 to i64
  %mul47 = mul nsw i64 %conv46, %conv45
  %conv48 = sext i32 %xor11 to i64
  %conv49 = sext i32 %xor21 to i64
  %mul50 = mul nsw i64 %conv49, %conv48
  %conv53 = sext i32 %xor13 to i64
  %conv54 = sext i32 %xor19 to i64
  %mul55 = mul nsw i64 %conv54, %conv53
  %conv56 = sext i32 %xor15 to i64
  %conv57 = sext i32 %xor17 to i64
  %mul58 = mul nsw i64 %conv57, %conv56
  %add = add i64 %mul55, %mul58
  %add43 = add i64 %add, %mul50
  %add44 = add i64 %add43, %mul47
  %add51 = add i64 %add44, %mul42
  %add52 = add i64 %add51, %mul39
  %add59 = add i64 %add52, %mul35
  %add60 = add i64 %add59, %mul
  %.pre = mul nsw i32 %b, %a
  %.pre285 = sext i32 %.pre to i64
  %.pre286 = mul nsw i32 %d, %c
  %.pre287 = sext i32 %.pre286 to i64
  br label %if.end108

if.then62:                                        ; preds = %entry
  %conv63 = sext i32 %xor1 to i64
  %conv64 = sext i32 %xor3 to i64
  %conv66 = sext i32 %xor5 to i64
  %conv68 = sext i32 %xor7 to i64
  %conv70 = sext i32 %xor9 to i64
  %conv72 = sext i32 %xor11 to i64
  %conv74 = sext i32 %xor13 to i64
  %conv76 = sext i32 %xor15 to i64
  %mul79 = mul nsw i32 %b, %a
  %conv80 = sext i32 %mul79 to i64
  %mul81 = mul nsw i32 %d, %c
  %conv82 = sext i32 %mul81 to i64
  %add65 = add nsw i64 %conv63, %conv80
  %add67 = add nsw i64 %add65, %conv82
  %add69 = add nsw i64 %add67, %conv64
  %add71 = add nsw i64 %add69, %conv66
  %add73 = add nsw i64 %add71, %conv68
  %add75 = add nsw i64 %add73, %conv70
  %add77 = add nsw i64 %add75, %conv72
  %add83 = add nsw i64 %add77, %conv74
  %add84 = add nsw i64 %add83, %conv76
  %.pre296 = sext i32 %xor17 to i64
  %.pre297 = sext i32 %xor19 to i64
  %.pre298 = sext i32 %xor21 to i64
  %.pre299 = sext i32 %xor23 to i64
  %.pre300 = sext i32 %xor25 to i64
  %.pre301 = sext i32 %xor27 to i64
  %.pre302 = sext i32 %xor29 to i64
  %.pre303 = sext i32 %xor31 to i64
  br label %if.end108

if.else85:                                        ; preds = %entry
  %conv86 = sext i32 %xor17 to i64
  %conv87 = sext i32 %xor19 to i64
  %conv89 = sext i32 %xor21 to i64
  %conv91 = sext i32 %xor23 to i64
  %conv93 = sext i32 %xor25 to i64
  %conv95 = sext i32 %xor27 to i64
  %conv97 = sext i32 %xor29 to i64
  %conv99 = sext i32 %xor31 to i64
  %mul102 = mul nsw i32 %b, %a
  %conv103 = sext i32 %mul102 to i64
  %mul104 = mul nsw i32 %d, %c
  %conv105 = sext i32 %mul104 to i64
  %add88 = add nsw i64 %conv105, %conv103
  %add90 = add nsw i64 %add88, %conv86
  %add92 = add nsw i64 %add90, %conv87
  %add94 = add nsw i64 %add92, %conv89
  %add96 = add nsw i64 %add94, %conv91
  %add98 = add nsw i64 %add96, %conv93
  %add100 = add nsw i64 %add98, %conv95
  %add106 = add nsw i64 %add100, %conv97
  %add107 = add nsw i64 %add106, %conv99
  %.pre288 = sext i32 %xor1 to i64
  %.pre289 = sext i32 %xor3 to i64
  %.pre290 = sext i32 %xor5 to i64
  %.pre291 = sext i32 %xor7 to i64
  %.pre292 = sext i32 %xor9 to i64
  %.pre293 = sext i32 %xor11 to i64
  %.pre294 = sext i32 %xor13 to i64
  %.pre295 = sext i32 %xor15 to i64
  br label %if.end108

if.end108:                                        ; preds = %if.then62, %if.else85, %if.then
  %conv144.pre-phi = phi i64 [ %.pre303, %if.then62 ], [ %conv99, %if.else85 ], [ %conv32, %if.then ]
  %conv142.pre-phi = phi i64 [ %.pre302, %if.then62 ], [ %conv97, %if.else85 ], [ %conv34, %if.then ]
  %conv140.pre-phi = phi i64 [ %.pre301, %if.then62 ], [ %conv95, %if.else85 ], [ %conv38, %if.then ]
  %conv138.pre-phi = phi i64 [ %.pre300, %if.then62 ], [ %conv93, %if.else85 ], [ %conv41, %if.then ]
  %conv136.pre-phi = phi i64 [ %.pre299, %if.then62 ], [ %conv91, %if.else85 ], [ %conv46, %if.then ]
  %conv134.pre-phi = phi i64 [ %.pre298, %if.then62 ], [ %conv89, %if.else85 ], [ %conv49, %if.then ]
  %conv132.pre-phi = phi i64 [ %.pre297, %if.then62 ], [ %conv87, %if.else85 ], [ %conv54, %if.then ]
  %conv131.pre-phi = phi i64 [ %.pre296, %if.then62 ], [ %conv86, %if.else85 ], [ %conv57, %if.then ]
  %conv128.pre-phi = phi i64 [ %conv76, %if.then62 ], [ %.pre295, %if.else85 ], [ %conv56, %if.then ]
  %conv126.pre-phi = phi i64 [ %conv74, %if.then62 ], [ %.pre294, %if.else85 ], [ %conv53, %if.then ]
  %conv124.pre-phi = phi i64 [ %conv72, %if.then62 ], [ %.pre293, %if.else85 ], [ %conv48, %if.then ]
  %conv122.pre-phi = phi i64 [ %conv70, %if.then62 ], [ %.pre292, %if.else85 ], [ %conv45, %if.then ]
  %conv120.pre-phi = phi i64 [ %conv68, %if.then62 ], [ %.pre291, %if.else85 ], [ %conv40, %if.then ]
  %conv118.pre-phi = phi i64 [ %conv66, %if.then62 ], [ %.pre290, %if.else85 ], [ %conv37, %if.then ]
  %conv116.pre-phi = phi i64 [ %conv64, %if.then62 ], [ %.pre289, %if.else85 ], [ %conv33, %if.then ]
  %conv115.pre-phi = phi i64 [ %conv63, %if.then62 ], [ %.pre288, %if.else85 ], [ %conv, %if.then ]
  %conv112.pre-phi = phi i64 [ %conv82, %if.then62 ], [ %conv105, %if.else85 ], [ %.pre287, %if.then ]
  %conv110.pre-phi = phi i64 [ %conv80, %if.then62 ], [ %conv103, %if.else85 ], [ %.pre285, %if.then ]
  %acc.0 = phi i64 [ %add84, %if.then62 ], [ %add107, %if.else85 ], [ %add60, %if.then ]
  %conv147 = sext i32 %a to i64
  %conv148 = sext i32 %b to i64
  %conv150 = sext i32 %c to i64
  %conv152 = sext i32 %d to i64
  %conv154 = sext i32 %e to i64
  %conv156 = sext i32 %f to i64
  %conv158 = sext i32 %g to i64
  %conv160 = sext i32 %h to i64
  %conv163 = sext i32 %i to i64
  %conv164 = sext i32 %j to i64
  %conv166 = sext i32 %k to i64
  %conv168 = sext i32 %l to i64
  %conv170 = sext i32 %m to i64
  %conv172 = sext i32 %n to i64
  %conv174 = sext i32 %o to i64
  %conv176 = sext i32 %p to i64
  %add113 = add nsw i64 %conv148, %conv147
  %add114 = add nsw i64 %add113, %conv150
  %add117 = add nsw i64 %add114, %conv110.pre-phi
  %add119 = add nsw i64 %add117, %conv152
  %add121 = add nsw i64 %add119, %conv115.pre-phi
  %add123 = add nsw i64 %add121, %conv154
  %add125 = add nsw i64 %add123, %conv116.pre-phi
  %add127 = add nsw i64 %add125, %conv112.pre-phi
  %add129 = add nsw i64 %add127, %conv156
  %add130 = add nsw i64 %add129, %conv118.pre-phi
  %add133 = add nsw i64 %add130, %conv158
  %add135 = add nsw i64 %add133, %conv120.pre-phi
  %add137 = add nsw i64 %add135, %conv160
  %add139 = add nsw i64 %add137, %conv122.pre-phi
  %add141 = add nsw i64 %add139, %conv163
  %add143 = add nsw i64 %add141, %conv124.pre-phi
  %add145 = add nsw i64 %add143, %conv164
  %add146 = add nsw i64 %add145, %conv126.pre-phi
  %add149 = add nsw i64 %add146, %conv166
  %add151 = add nsw i64 %add149, %conv128.pre-phi
  %add153 = add nsw i64 %add151, %conv168
  %add155 = add nsw i64 %add153, %conv131.pre-phi
  %add157 = add nsw i64 %add155, %conv170
  %add159 = add nsw i64 %add157, %conv132.pre-phi
  %add161 = add nsw i64 %add159, %conv172
  %add162 = add nsw i64 %add161, %conv134.pre-phi
  %add165 = add nsw i64 %add162, %conv174
  %add167 = add nsw i64 %add165, %conv136.pre-phi
  %add169 = add nsw i64 %add167, %conv176
  %add171 = add nsw i64 %add169, %conv138.pre-phi
  %add173 = add nsw i64 %add171, %conv140.pre-phi
  %add175 = add nsw i64 %add173, %conv142.pre-phi
  %add177 = add nsw i64 %add175, %conv144.pre-phi
  %add178 = add i64 %add177, %acc.0
  ret i64 %add178
}

; Function Attrs: mustprogress norecurse nounwind uwtable
define dso_local noundef i32 @main(i32 noundef %argc, ptr noundef readonly captures(none) %argv) local_unnamed_addr #2 {
entry:
  %sink = alloca i64, align 8
  %cmp = icmp sgt i32 %argc, 1
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %arrayidx = getelementptr inbounds nuw i8, ptr %argv, i64 8
  %0 = load ptr, ptr %arrayidx, align 8, !tbaa !9
  %call.i = tail call i64 @__isoc23_strtol(ptr noundef nonnull %0, ptr noundef null, i32 noundef 10) #5
  %conv.i = trunc i64 %call.i to i32
  br label %cond.end

cond.end:                                         ; preds = %entry, %cond.true
  %cond = phi i32 [ %conv.i, %cond.true ], [ 7, %entry ]
  call void @llvm.lifetime.start.p0(ptr nonnull %sink)
  store volatile i64 0, ptr %sink, align 8, !tbaa !12
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %sink.0.sink.0.sink.0.sink.0.86 = load volatile i64, ptr %sink, align 8, !tbaa !12
  %call41 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %sink.0.sink.0.sink.0.sink.0.86)
  call void @llvm.lifetime.end.p0(ptr nonnull %sink)
  ret i32 0

for.body:                                         ; preds = %cond.end, %for.body
  %idx.094 = phi i32 [ 0, %cond.end ], [ %inc, %for.body ]
  %mul = mul nsw i32 %idx.094, %cond
  %mul2 = mul i32 %mul, 67
  %and = and i32 %mul2, 255
  %and5 = and i32 %mul, 255
  %mul7 = mul i32 %mul, 193
  %and8 = and i32 %mul7, 255
  %mul10 = mul i32 %mul, 13
  %and11 = and i32 %mul10, 255
  %xor = xor i32 %mul2, %cond
  %and12 = and i32 %xor, 255
  %xor13 = xor i32 %mul, %cond
  %and14 = and i32 %xor13, 255
  %xor15 = xor i32 %mul7, %cond
  %and16 = and i32 %xor15, 255
  %xor17 = xor i32 %mul10, %cond
  %and18 = and i32 %xor17, 255
  %add = mul i32 %mul, 68
  %and19 = and i32 %add, 252
  %add20 = mul i32 %mul, 206
  %and21 = and i32 %add20, 254
  %add22 = add i32 %xor, %xor13
  %and23 = and i32 %add22, 255
  %add24 = add i32 %xor15, %xor17
  %and25 = and i32 %add24, 255
  %xor26 = xor i32 %and, %and8
  %xor28 = xor i32 %and11, %and5
  %xor30 = xor i32 %and12, %and16
  %xor32 = xor i32 %and18, %and14
  %and35 = and i32 %idx.094, 1
  %cmp36 = icmp ne i32 %and35, 0
  %rem = urem i32 %idx.094, 3
  %call37 = tail call noundef i64 @_Z23heavy_register_pressureiiiiiiiiiiiiiiiib(i32 noundef %and, i32 noundef %and5, i32 noundef %and8, i32 noundef %and11, i32 noundef %and12, i32 noundef %and14, i32 noundef %and16, i32 noundef %and18, i32 noundef %and19, i32 noundef %and21, i32 noundef %and23, i32 noundef %and25, i32 noundef %xor26, i32 noundef %xor28, i32 noundef %xor30, i32 noundef %xor32, i1 noundef zeroext %cmp36)
  %sink.0.sink.0.sink.0.sink.0. = load volatile i64, ptr %sink, align 8, !tbaa !12
  %add38 = add nsw i64 %sink.0.sink.0.sink.0.sink.0., %call37
  store volatile i64 %add38, ptr %sink, align 8, !tbaa !12
  %call39 = tail call noundef i64 @_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii(i32 noundef %and, i32 noundef %and5, i32 noundef %and8, i32 noundef %and11, i32 noundef %and12, i32 noundef %and14, i32 noundef %and16, i32 noundef %and18, i32 noundef %and19, i32 noundef %and21, i32 noundef %and23, i32 noundef %and25, i32 noundef %xor26, i32 noundef %xor28, i32 noundef %xor30, i32 noundef %xor32, i32 noundef %rem)
  %sink.0.sink.0.sink.0.sink.0.85 = load volatile i64, ptr %sink, align 8, !tbaa !12
  %add40 = add nsw i64 %sink.0.sink.0.sink.0.sink.0.85, %call39
  store volatile i64 %add40, ptr %sink, align 8, !tbaa !12
  %inc = add nuw nsw i32 %idx.094, 1
  %exitcond.not = icmp eq i32 %inc, 30000000
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !14
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
!9 = !{!10, !10, i64 0}
!10 = !{!"p1 omnipotent char", !11, i64 0}
!11 = !{!"any pointer", !7, i64 0}
!12 = !{!13, !13, i64 0}
!13 = !{!"long long", !7, i64 0}
!14 = distinct !{!14, !15}
!15 = !{!"llvm.loop.mustprogress"}
