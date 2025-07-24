; ModuleID = 'dense_ops.c'
source_filename = "dense_ops.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-unknown-elf"

@main.A = internal global [64 x [64 x float]] zeroinitializer, align 4
@main.B = internal global [64 x [64 x float]] zeroinitializer, align 4
@main.C = internal global [64 x [64 x float]] zeroinitializer, align 4
@.str = private unnamed_addr constant [14 x i8] c"C[0][0] = %f\0A\00", align 1
@__const.main.coef = private unnamed_addr constant [5 x float] [float 0x3FB99999A0000000, float 0x3FC3333340000000, float 5.000000e-01, float 0x3FC3333340000000, float 0x3FB99999A0000000], align 4
@.str.1 = private unnamed_addr constant [13 x i8] c"out[0] = %f\0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"total = %f\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @matmul(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca float, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %11

11:                                               ; preds = %51, %3
  %12 = load i32, ptr %7, align 4
  %13 = icmp slt i32 %12, 64
  br i1 %13, label %14, label %54

14:                                               ; preds = %11
  store i32 0, ptr %8, align 4
  br label %15

15:                                               ; preds = %47, %14
  %16 = load i32, ptr %8, align 4
  %17 = icmp slt i32 %16, 64
  br i1 %17, label %18, label %50

18:                                               ; preds = %15
  store float 0.000000e+00, ptr %9, align 4
  store i32 0, ptr %10, align 4
  br label %19

19:                                               ; preds = %37, %18
  %20 = load i32, ptr %10, align 4
  %21 = icmp slt i32 %20, 64
  br i1 %21, label %22, label %40

22:                                               ; preds = %19
  %23 = load ptr, ptr %4, align 4
  %24 = load i32, ptr %7, align 4
  %25 = getelementptr inbounds [64 x float], ptr %23, i32 %24
  %26 = load i32, ptr %10, align 4
  %27 = getelementptr inbounds [64 x float], ptr %25, i32 0, i32 %26
  %28 = load float, ptr %27, align 4
  %29 = load ptr, ptr %5, align 4
  %30 = load i32, ptr %10, align 4
  %31 = getelementptr inbounds [64 x float], ptr %29, i32 %30
  %32 = load i32, ptr %8, align 4
  %33 = getelementptr inbounds [64 x float], ptr %31, i32 0, i32 %32
  %34 = load float, ptr %33, align 4
  %35 = load float, ptr %9, align 4
  %36 = call float @llvm.fmuladd.f32(float %28, float %34, float %35)
  store float %36, ptr %9, align 4
  br label %37

37:                                               ; preds = %22
  %38 = load i32, ptr %10, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %10, align 4
  br label %19, !llvm.loop !6

40:                                               ; preds = %19
  %41 = load float, ptr %9, align 4
  %42 = load ptr, ptr %6, align 4
  %43 = load i32, ptr %7, align 4
  %44 = getelementptr inbounds [64 x float], ptr %42, i32 %43
  %45 = load i32, ptr %8, align 4
  %46 = getelementptr inbounds [64 x float], ptr %44, i32 0, i32 %45
  store float %41, ptr %46, align 4
  br label %47

47:                                               ; preds = %40
  %48 = load i32, ptr %8, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %8, align 4
  br label %15, !llvm.loop !8

50:                                               ; preds = %15
  br label %51

51:                                               ; preds = %50
  %52 = load i32, ptr %7, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %7, align 4
  br label %11, !llvm.loop !9

54:                                               ; preds = %11
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @conv5(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca ptr, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca float, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %5, align 4
  store ptr %1, ptr %6, align 4
  store ptr %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %12

12:                                               ; preds = %43, %4
  %13 = load i32, ptr %9, align 4
  %14 = load i32, ptr %8, align 4
  %15 = sub nsw i32 %14, 5
  %16 = add nsw i32 %15, 1
  %17 = icmp slt i32 %13, %16
  br i1 %17, label %18, label %46

18:                                               ; preds = %12
  store float 0.000000e+00, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %19

19:                                               ; preds = %35, %18
  %20 = load i32, ptr %11, align 4
  %21 = icmp slt i32 %20, 5
  br i1 %21, label %22, label %38

22:                                               ; preds = %19
  %23 = load ptr, ptr %5, align 4
  %24 = load i32, ptr %9, align 4
  %25 = load i32, ptr %11, align 4
  %26 = add nsw i32 %24, %25
  %27 = getelementptr inbounds float, ptr %23, i32 %26
  %28 = load float, ptr %27, align 4
  %29 = load ptr, ptr %7, align 4
  %30 = load i32, ptr %11, align 4
  %31 = getelementptr inbounds float, ptr %29, i32 %30
  %32 = load float, ptr %31, align 4
  %33 = load float, ptr %10, align 4
  %34 = call float @llvm.fmuladd.f32(float %28, float %32, float %33)
  store float %34, ptr %10, align 4
  br label %35

35:                                               ; preds = %22
  %36 = load i32, ptr %11, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %11, align 4
  br label %19, !llvm.loop !10

38:                                               ; preds = %19
  %39 = load float, ptr %10, align 4
  %40 = load ptr, ptr %6, align 4
  %41 = load i32, ptr %9, align 4
  %42 = getelementptr inbounds float, ptr %40, i32 %41
  store float %39, ptr %42, align 4
  br label %43

43:                                               ; preds = %38
  %44 = load i32, ptr %9, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %9, align 4
  br label %12, !llvm.loop !11

46:                                               ; preds = %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local float @exp_sum(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store float 0.000000e+00, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %7

7:                                                ; preds = %27, %2
  %8 = load i32, ptr %6, align 4
  %9 = load i32, ptr %4, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %30

11:                                               ; preds = %7
  %12 = load ptr, ptr %3, align 4
  %13 = load i32, ptr %6, align 4
  %14 = getelementptr inbounds float, ptr %12, i32 %13
  %15 = load float, ptr %14, align 4
  %16 = call float @expf(float noundef %15) #6
  %17 = fadd float %16, 1.000000e+00
  %18 = load ptr, ptr %3, align 4
  %19 = load i32, ptr %6, align 4
  %20 = getelementptr inbounds float, ptr %18, i32 %19
  store float %17, ptr %20, align 4
  %21 = load ptr, ptr %3, align 4
  %22 = load i32, ptr %6, align 4
  %23 = getelementptr inbounds float, ptr %21, i32 %22
  %24 = load float, ptr %23, align 4
  %25 = load float, ptr %5, align 4
  %26 = fadd float %25, %24
  store float %26, ptr %5, align 4
  br label %27

27:                                               ; preds = %11
  %28 = load i32, ptr %6, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr %6, align 4
  br label %7, !llvm.loop !12

30:                                               ; preds = %7
  %31 = load float, ptr %5, align 4
  ret float %31
}

; Function Attrs: nounwind
declare dso_local float @expf(float noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca [5 x float], align 4
  %7 = alloca i32, align 4
  %8 = alloca float, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %9

9:                                                ; preds = %39, %0
  %10 = load i32, ptr %2, align 4
  %11 = icmp slt i32 %10, 64
  br i1 %11, label %12, label %42

12:                                               ; preds = %9
  store i32 0, ptr %3, align 4
  br label %13

13:                                               ; preds = %35, %12
  %14 = load i32, ptr %3, align 4
  %15 = icmp slt i32 %14, 64
  br i1 %15, label %16, label %38

16:                                               ; preds = %13
  %17 = load i32, ptr %2, align 4
  %18 = load i32, ptr %3, align 4
  %19 = add nsw i32 %17, %18
  %20 = sitofp i32 %19 to float
  %21 = fmul float %20, 0x3F847AE140000000
  %22 = load i32, ptr %2, align 4
  %23 = getelementptr inbounds [64 x [64 x float]], ptr @main.A, i32 0, i32 %22
  %24 = load i32, ptr %3, align 4
  %25 = getelementptr inbounds [64 x float], ptr %23, i32 0, i32 %24
  store float %21, ptr %25, align 4
  %26 = load i32, ptr %2, align 4
  %27 = load i32, ptr %3, align 4
  %28 = sub nsw i32 %26, %27
  %29 = sitofp i32 %28 to float
  %30 = fmul float %29, 0x3F947AE140000000
  %31 = load i32, ptr %2, align 4
  %32 = getelementptr inbounds [64 x [64 x float]], ptr @main.B, i32 0, i32 %31
  %33 = load i32, ptr %3, align 4
  %34 = getelementptr inbounds [64 x float], ptr %32, i32 0, i32 %33
  store float %30, ptr %34, align 4
  br label %35

35:                                               ; preds = %16
  %36 = load i32, ptr %3, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %3, align 4
  br label %13, !llvm.loop !13

38:                                               ; preds = %13
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %2, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %2, align 4
  br label %9, !llvm.loop !14

42:                                               ; preds = %9
  call void @matmul(ptr noundef @main.A, ptr noundef @main.B, ptr noundef @main.C)
  %43 = load float, ptr @main.C, align 4
  %44 = fpext float %43 to double
  %45 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %44)
  %46 = call noalias ptr @malloc(i32 noundef 16384) #7
  store ptr %46, ptr %4, align 4
  %47 = call noalias ptr @malloc(i32 noundef 16384) #7
  store ptr %47, ptr %5, align 4
  call void @llvm.memcpy.p0.p0.i32(ptr align 4 %6, ptr align 4 @__const.main.coef, i32 20, i1 false)
  store i32 0, ptr %7, align 4
  br label %48

48:                                               ; preds = %58, %42
  %49 = load i32, ptr %7, align 4
  %50 = icmp slt i32 %49, 4096
  br i1 %50, label %51, label %61

51:                                               ; preds = %48
  %52 = load i32, ptr %7, align 4
  %53 = sitofp i32 %52 to float
  %54 = fdiv float %53, 1.000000e+01
  %55 = load ptr, ptr %4, align 4
  %56 = load i32, ptr %7, align 4
  %57 = getelementptr inbounds float, ptr %55, i32 %56
  store float %54, ptr %57, align 4
  br label %58

58:                                               ; preds = %51
  %59 = load i32, ptr %7, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %7, align 4
  br label %48, !llvm.loop !15

61:                                               ; preds = %48
  %62 = load ptr, ptr %4, align 4
  %63 = load ptr, ptr %5, align 4
  %64 = getelementptr inbounds [5 x float], ptr %6, i32 0, i32 0
  call void @conv5(ptr noundef %62, ptr noundef %63, ptr noundef %64, i32 noundef 4096)
  %65 = load ptr, ptr %5, align 4
  %66 = getelementptr inbounds float, ptr %65, i32 0
  %67 = load float, ptr %66, align 4
  %68 = fpext float %67 to double
  %69 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %68)
  %70 = load ptr, ptr %5, align 4
  %71 = call float @exp_sum(ptr noundef %70, i32 noundef 4096)
  store float %71, ptr %8, align 4
  %72 = load float, ptr %8, align 4
  %73 = fpext float %72 to double
  %74 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %73)
  %75 = load ptr, ptr %4, align 4
  call void @free(ptr noundef %75)
  %76 = load ptr, ptr %5, align 4
  call void @free(ptr noundef %76)
  ret i32 0
}

declare dso_local i32 @printf(ptr noundef, ...) #3

; Function Attrs: allocsize(0)
declare dso_local noalias ptr @malloc(i32 noundef) #4

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i32(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i32, i1 immarg) #5

declare dso_local void @free(ptr noundef) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #6 = { nounwind }
attributes #7 = { allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"ilp32"}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{i32 8, !"SmallDataLimit", i32 8}
!5 = !{!"clang version 17.0.2 (https://github.com/llvm/llvm-project.git b2417f51dbbd7435eb3aaf203de24de6754da50e)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
