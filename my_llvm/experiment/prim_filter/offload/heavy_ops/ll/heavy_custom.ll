; ModuleID = 'heavy.ll'
source_filename = "heavy_ops.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-unknown-elf"

@main.A = internal global [64 x [64 x [64 x float]]] zeroinitializer, align 4
@main.B = internal global [64 x [64 x [64 x float]]] zeroinitializer, align 4
@main.C = internal global [64 x [64 x [64 x float]]] zeroinitializer, align 4
@.str = private unnamed_addr constant [15 x i8] c"C[0][0][0]=%f\0A\00", align 1
@main.IN = internal global [16 x [36 x [36 x float]]] zeroinitializer, align 4
@main.Wt = internal global [16 x [5 x [5 x float]]] zeroinitializer, align 4
@main.O = internal global [32 x [32 x float]] zeroinitializer, align 4
@.str.1 = private unnamed_addr constant [12 x i8] c"O[0][0]=%f\0A\00", align 1
@main.sig = internal global [4096 x { float, float }] zeroinitializer, align 4
@.str.2 = private unnamed_addr constant [15 x i8] c"FFT[1]=%f%+fi\0A\00", align 1
@.str.3 = private unnamed_addr constant [11 x i8] c"vec[0]=%f\0A\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"scan[%d]=%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @batched_gemm(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca float, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %12

12:                                               ; preds = %63, %3
  %13 = load i32, ptr %7, align 4
  %14 = icmp slt i32 %13, 64
  br i1 %14, label %15, label %65

15:                                               ; preds = %12
  store i32 0, ptr %8, align 4
  br label %16

16:                                               ; preds = %60, %15
  %17 = load i32, ptr %8, align 4
  %18 = icmp slt i32 %17, 64
  br i1 %18, label %19, label %62

19:                                               ; preds = %16
  store i32 0, ptr %9, align 4
  br label %20

20:                                               ; preds = %57, %19
  %21 = load i32, ptr %9, align 4
  %22 = icmp slt i32 %21, 64
  br i1 %22, label %23, label %59

23:                                               ; preds = %20
  store float 0.000000e+00, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %24

24:                                               ; preds = %46, %23
  %25 = load i32, ptr %11, align 4
  %26 = icmp slt i32 %25, 64
  br i1 %26, label %27, label %48

27:                                               ; preds = %24
  %28 = load ptr, ptr %4, align 4
  %29 = load i32, ptr %7, align 4
  %30 = getelementptr inbounds [64 x [64 x float]], ptr %28, i32 %29
  %31 = load i32, ptr %8, align 4
  %32 = getelementptr inbounds [64 x [64 x float]], ptr %30, i32 0, i32 %31
  %33 = load i32, ptr %11, align 4
  %34 = getelementptr inbounds [64 x float], ptr %32, i32 0, i32 %33
  %35 = load float, ptr %34, align 4
  %36 = load ptr, ptr %5, align 4
  %37 = load i32, ptr %7, align 4
  %38 = getelementptr inbounds [64 x [64 x float]], ptr %36, i32 %37
  %39 = load i32, ptr %11, align 4
  %40 = getelementptr inbounds [64 x [64 x float]], ptr %38, i32 0, i32 %39
  %41 = load i32, ptr %9, align 4
  %42 = getelementptr inbounds [64 x float], ptr %40, i32 0, i32 %41
  %43 = load float, ptr %42, align 4
  %44 = load float, ptr %10, align 4
  %45 = call float @llvm.fmuladd.f32(float %35, float %43, float %44)
  store float %45, ptr %10, align 4
  br label %46

46:                                               ; preds = %27
  %47 = load i32, ptr %11, align 4
  %custom3 = call i32 @llvm.riscv.custom3(i32 %47, i32 1)
  store i32 %custom3, ptr %11, align 4
  br label %24, !llvm.loop !6

48:                                               ; preds = %24
  %49 = load float, ptr %10, align 4
  %50 = load ptr, ptr %6, align 4
  %51 = load i32, ptr %7, align 4
  %52 = getelementptr inbounds [64 x [64 x float]], ptr %50, i32 %51
  %53 = load i32, ptr %8, align 4
  %54 = getelementptr inbounds [64 x [64 x float]], ptr %52, i32 0, i32 %53
  %55 = load i32, ptr %9, align 4
  %56 = getelementptr inbounds [64 x float], ptr %54, i32 0, i32 %55
  store float %49, ptr %56, align 4
  br label %57

57:                                               ; preds = %48
  %58 = load i32, ptr %9, align 4
  %custom31 = call i32 @llvm.riscv.custom3(i32 %58, i32 1)
  store i32 %custom31, ptr %9, align 4
  br label %20, !llvm.loop !8

59:                                               ; preds = %20
  br label %60

60:                                               ; preds = %59
  %61 = load i32, ptr %8, align 4
  %custom32 = call i32 @llvm.riscv.custom3(i32 %61, i32 1)
  store i32 %custom32, ptr %8, align 4
  br label %16, !llvm.loop !9

62:                                               ; preds = %16
  br label %63

63:                                               ; preds = %62
  %64 = load i32, ptr %7, align 4
  %custom33 = call i32 @llvm.riscv.custom3(i32 %64, i32 1)
  store i32 %custom33, ptr %7, align 4
  br label %12, !llvm.loop !10

65:                                               ; preds = %12
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @conv2d(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca ptr, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca float, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store ptr %1, ptr %5, align 4
  store ptr %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %13

13:                                               ; preds = %71, %3
  %14 = load i32, ptr %7, align 4
  %15 = icmp slt i32 %14, 32
  br i1 %15, label %16, label %73

16:                                               ; preds = %13
  store i32 0, ptr %8, align 4
  br label %17

17:                                               ; preds = %68, %16
  %18 = load i32, ptr %8, align 4
  %19 = icmp slt i32 %18, 32
  br i1 %19, label %20, label %70

20:                                               ; preds = %17
  store float 0.000000e+00, ptr %9, align 4
  store i32 0, ptr %10, align 4
  br label %21

21:                                               ; preds = %59, %20
  %22 = load i32, ptr %10, align 4
  %23 = icmp slt i32 %22, 16
  br i1 %23, label %24, label %61

24:                                               ; preds = %21
  store i32 0, ptr %11, align 4
  br label %25

25:                                               ; preds = %56, %24
  %26 = load i32, ptr %11, align 4
  %27 = icmp slt i32 %26, 5
  br i1 %27, label %28, label %58

28:                                               ; preds = %25
  store i32 0, ptr %12, align 4
  br label %29

29:                                               ; preds = %53, %28
  %30 = load i32, ptr %12, align 4
  %31 = icmp slt i32 %30, 5
  br i1 %31, label %32, label %55

32:                                               ; preds = %29
  %33 = load ptr, ptr %4, align 4
  %34 = load i32, ptr %10, align 4
  %35 = getelementptr inbounds [36 x [36 x float]], ptr %33, i32 %34
  %36 = load i32, ptr %7, align 4
  %37 = load i32, ptr %11, align 4
  %custom3 = call i32 @llvm.riscv.custom3(i32 %36, i32 %37)
  %38 = getelementptr inbounds [36 x [36 x float]], ptr %35, i32 0, i32 %custom3
  %39 = load i32, ptr %8, align 4
  %40 = load i32, ptr %12, align 4
  %custom31 = call i32 @llvm.riscv.custom3(i32 %39, i32 %40)
  %41 = getelementptr inbounds [36 x float], ptr %38, i32 0, i32 %custom31
  %42 = load float, ptr %41, align 4
  %43 = load ptr, ptr %5, align 4
  %44 = load i32, ptr %10, align 4
  %45 = getelementptr inbounds [5 x [5 x float]], ptr %43, i32 %44
  %46 = load i32, ptr %11, align 4
  %47 = getelementptr inbounds [5 x [5 x float]], ptr %45, i32 0, i32 %46
  %48 = load i32, ptr %12, align 4
  %49 = getelementptr inbounds [5 x float], ptr %47, i32 0, i32 %48
  %50 = load float, ptr %49, align 4
  %51 = load float, ptr %9, align 4
  %52 = call float @llvm.fmuladd.f32(float %42, float %50, float %51)
  store float %52, ptr %9, align 4
  br label %53

53:                                               ; preds = %32
  %54 = load i32, ptr %12, align 4
  %custom32 = call i32 @llvm.riscv.custom3(i32 %54, i32 1)
  store i32 %custom32, ptr %12, align 4
  br label %29, !llvm.loop !11

55:                                               ; preds = %29
  br label %56

56:                                               ; preds = %55
  %57 = load i32, ptr %11, align 4
  %custom33 = call i32 @llvm.riscv.custom3(i32 %57, i32 1)
  store i32 %custom33, ptr %11, align 4
  br label %25, !llvm.loop !12

58:                                               ; preds = %25
  br label %59

59:                                               ; preds = %58
  %60 = load i32, ptr %10, align 4
  %custom34 = call i32 @llvm.riscv.custom3(i32 %60, i32 1)
  store i32 %custom34, ptr %10, align 4
  br label %21, !llvm.loop !13

61:                                               ; preds = %21
  %62 = load float, ptr %9, align 4
  %63 = load ptr, ptr %6, align 4
  %64 = load i32, ptr %7, align 4
  %65 = getelementptr inbounds [32 x float], ptr %63, i32 %64
  %66 = load i32, ptr %8, align 4
  %67 = getelementptr inbounds [32 x float], ptr %65, i32 0, i32 %66
  store float %62, ptr %67, align 4
  br label %68

68:                                               ; preds = %61
  %69 = load i32, ptr %8, align 4
  %custom35 = call i32 @llvm.riscv.custom3(i32 %69, i32 1)
  store i32 %custom35, ptr %8, align 4
  br label %17, !llvm.loop !14

70:                                               ; preds = %17
  br label %71

71:                                               ; preds = %70
  %72 = load i32, ptr %7, align 4
  %custom36 = call i32 @llvm.riscv.custom3(i32 %72, i32 1)
  store i32 %custom36, ptr %7, align 4
  br label %13, !llvm.loop !15

73:                                               ; preds = %13
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @fft_4096(ptr noundef %0) #0 {
  %2 = alloca ptr, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca { float, float }, align 4
  %7 = alloca { double, double }, align 8
  %8 = alloca { double, double }, align 8
  %9 = alloca { double, double }, align 8
  %10 = alloca i32, align 4
  %11 = alloca { float, float }, align 4
  %12 = alloca i32, align 4
  %13 = alloca { float, float }, align 4
  %14 = alloca { float, float }, align 4
  %15 = alloca { float, float }, align 4
  %16 = alloca { float, float }, align 4
  store ptr %0, ptr %2, align 4
  store i32 1, ptr %3, align 4
  br label %17

17:                                               ; preds = %161, %1
  %18 = load i32, ptr %3, align 4
  %19 = icmp sle i32 %18, 12
  br i1 %19, label %20, label %163

20:                                               ; preds = %17
  %21 = load i32, ptr %3, align 4
  %custom3 = call i32 @llvm.riscv.custom3(i32 1, i32 %21)
  store i32 %custom3, ptr %4, align 4
  %22 = load i32, ptr %4, align 4
  %custom31 = call i32 @llvm.riscv.custom3(i32 %22, i32 1)
  store i32 %custom31, ptr %5, align 4
  %23 = load i32, ptr %5, align 4
  %24 = sitofp i32 %23 to double
  call void @__divdc3(ptr sret({ double, double }) align 8 %7, double noundef -0.000000e+00, double noundef 0xC00921FB54442D18, double noundef %24, double noundef 0.000000e+00) #6
  %25 = getelementptr inbounds { double, double }, ptr %7, i32 0, i32 0
  %26 = load double, ptr %25, align 8
  %27 = getelementptr inbounds { double, double }, ptr %7, i32 0, i32 1
  %28 = load double, ptr %27, align 8
  %29 = getelementptr inbounds { double, double }, ptr %9, i32 0, i32 0
  %30 = getelementptr inbounds { double, double }, ptr %9, i32 0, i32 1
  store double %26, ptr %29, align 8
  store double %28, ptr %30, align 8
  call void @cexp(ptr sret({ double, double }) align 8 %8, ptr noundef %9) #6
  %31 = getelementptr inbounds { double, double }, ptr %8, i32 0, i32 0
  %32 = load double, ptr %31, align 8
  %33 = getelementptr inbounds { double, double }, ptr %8, i32 0, i32 1
  %34 = load double, ptr %33, align 8
  %35 = fptrunc double %32 to float
  %36 = fptrunc double %34 to float
  %37 = getelementptr inbounds { float, float }, ptr %6, i32 0, i32 0
  %38 = getelementptr inbounds { float, float }, ptr %6, i32 0, i32 1
  store float %35, ptr %37, align 4
  store float %36, ptr %38, align 4
  store i32 0, ptr %10, align 4
  br label %39

39:                                               ; preds = %157, %20
  %40 = load i32, ptr %10, align 4
  %41 = icmp slt i32 %40, 4096
  br i1 %41, label %42, label %160

42:                                               ; preds = %39
  %43 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 0
  %44 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 1
  store float 1.000000e+00, ptr %43, align 4
  store float 0.000000e+00, ptr %44, align 4
  store i32 0, ptr %12, align 4
  br label %45

45:                                               ; preds = %154, %42
  %46 = load i32, ptr %12, align 4
  %47 = load i32, ptr %5, align 4
  %48 = icmp slt i32 %46, %47
  br i1 %48, label %49, label %156

49:                                               ; preds = %45
  %50 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 0
  %51 = load float, ptr %50, align 4
  %52 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 1
  %53 = load float, ptr %52, align 4
  %54 = load ptr, ptr %2, align 4
  %55 = load i32, ptr %10, align 4
  %56 = load i32, ptr %12, align 4
  %custom32 = call i32 @llvm.riscv.custom3(i32 %55, i32 %56)
  %57 = load i32, ptr %5, align 4
  %custom33 = call i32 @llvm.riscv.custom3(i32 %custom32, i32 %57)
  %58 = getelementptr inbounds { float, float }, ptr %54, i32 %custom33
  %59 = getelementptr inbounds { float, float }, ptr %58, i32 0, i32 0
  %60 = load float, ptr %59, align 4
  %61 = getelementptr inbounds { float, float }, ptr %58, i32 0, i32 1
  %62 = load float, ptr %61, align 4
  %63 = fmul float %51, %60
  %64 = fmul float %53, %62
  %65 = fmul float %51, %62
  %66 = fmul float %53, %60
  %67 = fsub float %63, %64
  %68 = fadd float %65, %66
  %69 = fcmp uno float %67, %67
  br i1 %69, label %70, label %78, !prof !16

70:                                               ; preds = %49
  %71 = fcmp uno float %68, %68
  br i1 %71, label %72, label %78, !prof !16

72:                                               ; preds = %70
  %73 = call [2 x i32] @__mulsc3(float noundef %51, float noundef %53, float noundef %60, float noundef %62) #6
  store [2 x i32] %73, ptr %14, align 4
  %74 = getelementptr inbounds { float, float }, ptr %14, i32 0, i32 0
  %75 = load float, ptr %74, align 4
  %76 = getelementptr inbounds { float, float }, ptr %14, i32 0, i32 1
  %77 = load float, ptr %76, align 4
  br label %78

78:                                               ; preds = %72, %70, %49
  %79 = phi float [ %67, %49 ], [ %67, %70 ], [ %75, %72 ]
  %80 = phi float [ %68, %49 ], [ %68, %70 ], [ %77, %72 ]
  %81 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 0
  %82 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 1
  store float %79, ptr %81, align 4
  store float %80, ptr %82, align 4
  %83 = load ptr, ptr %2, align 4
  %84 = load i32, ptr %10, align 4
  %85 = load i32, ptr %12, align 4
  %custom34 = call i32 @llvm.riscv.custom3(i32 %84, i32 %85)
  %86 = getelementptr inbounds { float, float }, ptr %83, i32 %custom34
  %87 = getelementptr inbounds { float, float }, ptr %86, i32 0, i32 0
  %88 = load float, ptr %87, align 4
  %89 = getelementptr inbounds { float, float }, ptr %86, i32 0, i32 1
  %90 = load float, ptr %89, align 4
  %91 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 0
  %92 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 1
  store float %88, ptr %91, align 4
  store float %90, ptr %92, align 4
  %93 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 0
  %94 = load float, ptr %93, align 4
  %95 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 1
  %96 = load float, ptr %95, align 4
  %97 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 0
  %98 = load float, ptr %97, align 4
  %99 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 1
  %100 = load float, ptr %99, align 4
  %101 = fadd float %94, %98
  %102 = fadd float %96, %100
  %103 = load ptr, ptr %2, align 4
  %104 = load i32, ptr %10, align 4
  %105 = load i32, ptr %12, align 4
  %custom35 = call i32 @llvm.riscv.custom3(i32 %104, i32 %105)
  %106 = getelementptr inbounds { float, float }, ptr %103, i32 %custom35
  %107 = getelementptr inbounds { float, float }, ptr %106, i32 0, i32 0
  %108 = getelementptr inbounds { float, float }, ptr %106, i32 0, i32 1
  store float %101, ptr %107, align 4
  store float %102, ptr %108, align 4
  %109 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 0
  %110 = load float, ptr %109, align 4
  %111 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 1
  %112 = load float, ptr %111, align 4
  %113 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 0
  %114 = load float, ptr %113, align 4
  %115 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 1
  %116 = load float, ptr %115, align 4
  %117 = fsub float %110, %114
  %118 = fsub float %112, %116
  %119 = load ptr, ptr %2, align 4
  %120 = load i32, ptr %10, align 4
  %121 = load i32, ptr %12, align 4
  %custom36 = call i32 @llvm.riscv.custom3(i32 %120, i32 %121)
  %122 = load i32, ptr %5, align 4
  %custom37 = call i32 @llvm.riscv.custom3(i32 %custom36, i32 %122)
  %123 = getelementptr inbounds { float, float }, ptr %119, i32 %custom37
  %124 = getelementptr inbounds { float, float }, ptr %123, i32 0, i32 0
  %125 = getelementptr inbounds { float, float }, ptr %123, i32 0, i32 1
  store float %117, ptr %124, align 4
  store float %118, ptr %125, align 4
  %126 = getelementptr inbounds { float, float }, ptr %6, i32 0, i32 0
  %127 = load float, ptr %126, align 4
  %128 = getelementptr inbounds { float, float }, ptr %6, i32 0, i32 1
  %129 = load float, ptr %128, align 4
  %130 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 0
  %131 = load float, ptr %130, align 4
  %132 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 1
  %133 = load float, ptr %132, align 4
  %134 = fmul float %131, %127
  %135 = fmul float %133, %129
  %136 = fmul float %131, %129
  %137 = fmul float %133, %127
  %138 = fsub float %134, %135
  %139 = fadd float %136, %137
  %140 = fcmp uno float %138, %138
  br i1 %140, label %141, label %149, !prof !16

141:                                              ; preds = %78
  %142 = fcmp uno float %139, %139
  br i1 %142, label %143, label %149, !prof !16

143:                                              ; preds = %141
  %144 = call [2 x i32] @__mulsc3(float noundef %131, float noundef %133, float noundef %127, float noundef %129) #6
  store [2 x i32] %144, ptr %16, align 4
  %145 = getelementptr inbounds { float, float }, ptr %16, i32 0, i32 0
  %146 = load float, ptr %145, align 4
  %147 = getelementptr inbounds { float, float }, ptr %16, i32 0, i32 1
  %148 = load float, ptr %147, align 4
  br label %149

149:                                              ; preds = %143, %141, %78
  %150 = phi float [ %138, %78 ], [ %138, %141 ], [ %146, %143 ]
  %151 = phi float [ %139, %78 ], [ %139, %141 ], [ %148, %143 ]
  %152 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 0
  %153 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 1
  store float %150, ptr %152, align 4
  store float %151, ptr %153, align 4
  br label %154

154:                                              ; preds = %149
  %155 = load i32, ptr %12, align 4
  %custom38 = call i32 @llvm.riscv.custom3(i32 %155, i32 1)
  store i32 %custom38, ptr %12, align 4
  br label %45, !llvm.loop !17

156:                                              ; preds = %45
  br label %157

157:                                              ; preds = %156
  %158 = load i32, ptr %4, align 4
  %159 = load i32, ptr %10, align 4
  %custom39 = call i32 @llvm.riscv.custom3(i32 %159, i32 %158)
  store i32 %custom39, ptr %10, align 4
  br label %39, !llvm.loop !18

160:                                              ; preds = %39
  br label %161

161:                                              ; preds = %160
  %162 = load i32, ptr %3, align 4
  %custom310 = call i32 @llvm.riscv.custom3(i32 %162, i32 1)
  store i32 %custom310, ptr %3, align 4
  br label %17, !llvm.loop !19

163:                                              ; preds = %17
  ret void
}

; Function Attrs: nounwind
declare dso_local void @cexp(ptr sret({ double, double }) align 8, ptr noundef) #2

declare dso_local void @__divdc3(ptr, double, double, double, double)

declare dso_local [2 x i32] @__mulsc3(float, float, float, float)

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @gelu_layernorm(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca i32, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store double 0.000000e+00, ptr %5, align 8
  store double 0.000000e+00, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %14

14:                                               ; preds = %50, %2
  %15 = load i32, ptr %7, align 4
  %16 = load i32, ptr %4, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %52

18:                                               ; preds = %14
  %19 = load ptr, ptr %3, align 4
  %20 = load i32, ptr %7, align 4
  %21 = getelementptr inbounds float, ptr %19, i32 %20
  %22 = load float, ptr %21, align 4
  store float %22, ptr %8, align 4
  %23 = load float, ptr %8, align 4
  %24 = fmul float 5.000000e-01, %23
  %25 = load float, ptr %8, align 4
  %26 = load float, ptr %8, align 4
  %27 = fmul float 0x3FA6E4E260000000, %26
  %28 = load float, ptr %8, align 4
  %29 = fmul float %27, %28
  %30 = load float, ptr %8, align 4
  %31 = call float @llvm.fmuladd.f32(float %29, float %30, float %25)
  %32 = fmul float 0x3FE9884540000000, %31
  %33 = call float @tanhf(float noundef %32) #6
  %34 = fadd float 1.000000e+00, %33
  %35 = fmul float %24, %34
  store float %35, ptr %9, align 4
  %36 = load float, ptr %9, align 4
  %37 = load ptr, ptr %3, align 4
  %38 = load i32, ptr %7, align 4
  %39 = getelementptr inbounds float, ptr %37, i32 %38
  store float %36, ptr %39, align 4
  %40 = load float, ptr %9, align 4
  %41 = fpext float %40 to double
  %42 = load double, ptr %5, align 8
  %43 = fadd double %42, %41
  store double %43, ptr %5, align 8
  %44 = load float, ptr %9, align 4
  %45 = load float, ptr %9, align 4
  %46 = fmul float %44, %45
  %47 = fpext float %46 to double
  %48 = load double, ptr %6, align 8
  %49 = fadd double %48, %47
  store double %49, ptr %6, align 8
  br label %50

50:                                               ; preds = %18
  %51 = load i32, ptr %7, align 4
  %custom3 = call i32 @llvm.riscv.custom3(i32 %51, i32 1)
  store i32 %custom3, ptr %7, align 4
  br label %14, !llvm.loop !20

52:                                               ; preds = %14
  %53 = load double, ptr %5, align 8
  %54 = load i32, ptr %4, align 4
  %55 = sitofp i32 %54 to double
  %56 = fdiv double %53, %55
  store double %56, ptr %10, align 8
  %57 = load double, ptr %6, align 8
  %58 = load i32, ptr %4, align 4
  %59 = sitofp i32 %58 to double
  %60 = fdiv double %57, %59
  %61 = load double, ptr %10, align 8
  %62 = load double, ptr %10, align 8
  %63 = fneg double %61
  %64 = call double @llvm.fmuladd.f64(double %63, double %62, double %60)
  %65 = fadd double %64, 1.000000e-05
  store double %65, ptr %11, align 8
  %66 = load double, ptr %11, align 8
  %67 = call double @sqrt(double noundef %66) #6
  %68 = fdiv double 1.000000e+00, %67
  store double %68, ptr %12, align 8
  store i32 0, ptr %13, align 4
  br label %69

69:                                               ; preds = %87, %52
  %70 = load i32, ptr %13, align 4
  %71 = load i32, ptr %4, align 4
  %72 = icmp slt i32 %70, %71
  br i1 %72, label %73, label %89

73:                                               ; preds = %69
  %74 = load ptr, ptr %3, align 4
  %75 = load i32, ptr %13, align 4
  %76 = getelementptr inbounds float, ptr %74, i32 %75
  %77 = load float, ptr %76, align 4
  %78 = fpext float %77 to double
  %79 = load double, ptr %10, align 8
  %80 = fsub double %78, %79
  %81 = load double, ptr %12, align 8
  %82 = fmul double %80, %81
  %83 = fptrunc double %82 to float
  %84 = load ptr, ptr %3, align 4
  %85 = load i32, ptr %13, align 4
  %86 = getelementptr inbounds float, ptr %84, i32 %85
  store float %83, ptr %86, align 4
  br label %87

87:                                               ; preds = %73
  %88 = load i32, ptr %13, align 4
  %custom31 = call i32 @llvm.riscv.custom3(i32 %88, i32 1)
  store i32 %custom31, ptr %13, align 4
  br label %69, !llvm.loop !21

89:                                               ; preds = %69
  ret void
}

; Function Attrs: nounwind
declare dso_local float @tanhf(float noundef) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nounwind
declare dso_local double @sqrt(double noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @prefix_sum(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 1, ptr %5, align 4
  br label %10

10:                                               ; preds = %34, %2
  %11 = load i32, ptr %5, align 4
  %12 = load i32, ptr %4, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %36

14:                                               ; preds = %10
  store i32 0, ptr %6, align 4
  br label %15

15:                                               ; preds = %30, %14
  %16 = load i32, ptr %6, align 4
  %17 = load i32, ptr %4, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %33

19:                                               ; preds = %15
  %20 = load ptr, ptr %3, align 4
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %5, align 4
  %custom3 = call i32 @llvm.riscv.custom3(i32 %21, i32 %22)
  %custom31 = call i32 @llvm.riscv.custom3(i32 %custom3, i32 1)
  %23 = getelementptr inbounds i32, ptr %20, i32 %custom31
  %24 = load i32, ptr %23, align 4
  %25 = load ptr, ptr %3, align 4
  %26 = load i32, ptr %6, align 4
  %27 = load i32, ptr %5, align 4
  %custom32 = call i32 @llvm.riscv.custom3(i32 2, i32 %27)
  %custom33 = call i32 @llvm.riscv.custom3(i32 %26, i32 %custom32)
  %custom34 = call i32 @llvm.riscv.custom3(i32 %custom33, i32 1)
  %28 = getelementptr inbounds i32, ptr %25, i32 %custom34
  %29 = load i32, ptr %28, align 4
  %custom35 = call i32 @llvm.riscv.custom3(i32 %29, i32 %24)
  store i32 %custom35, ptr %28, align 4
  br label %30

30:                                               ; preds = %19
  %31 = load i32, ptr %5, align 4
  %custom36 = call i32 @llvm.riscv.custom3(i32 2, i32 %31)
  %32 = load i32, ptr %6, align 4
  %custom37 = call i32 @llvm.riscv.custom3(i32 %32, i32 %custom36)
  store i32 %custom37, ptr %6, align 4
  br label %15, !llvm.loop !22

33:                                               ; preds = %15
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %5, align 4
  %custom38 = call i32 @llvm.riscv.custom3(i32 %35, i32 1)
  store i32 %custom38, ptr %5, align 4
  br label %10, !llvm.loop !23

36:                                               ; preds = %10
  %37 = load ptr, ptr %3, align 4
  %38 = load i32, ptr %4, align 4
  %custom39 = call i32 @llvm.riscv.custom3(i32 %38, i32 1)
  %39 = getelementptr inbounds i32, ptr %37, i32 %custom39
  store i32 0, ptr %39, align 4
  %40 = load i32, ptr %4, align 4
  %custom310 = call i32 @llvm.riscv.custom3(i32 %40, i32 1)
  store i32 %custom310, ptr %7, align 4
  br label %41

41:                                               ; preds = %74, %36
  %42 = load i32, ptr %7, align 4
  %43 = icmp sge i32 %42, 1
  br i1 %43, label %44, label %76

44:                                               ; preds = %41
  store i32 0, ptr %8, align 4
  br label %45

45:                                               ; preds = %70, %44
  %46 = load i32, ptr %8, align 4
  %47 = load i32, ptr %4, align 4
  %48 = icmp slt i32 %46, %47
  br i1 %48, label %49, label %73

49:                                               ; preds = %45
  %50 = load ptr, ptr %3, align 4
  %51 = load i32, ptr %8, align 4
  %52 = load i32, ptr %7, align 4
  %custom311 = call i32 @llvm.riscv.custom3(i32 %51, i32 %52)
  %custom312 = call i32 @llvm.riscv.custom3(i32 %custom311, i32 1)
  %53 = getelementptr inbounds i32, ptr %50, i32 %custom312
  %54 = load i32, ptr %53, align 4
  store i32 %54, ptr %9, align 4
  %55 = load ptr, ptr %3, align 4
  %56 = load i32, ptr %8, align 4
  %57 = load i32, ptr %7, align 4
  %custom313 = call i32 @llvm.riscv.custom3(i32 2, i32 %57)
  %custom314 = call i32 @llvm.riscv.custom3(i32 %56, i32 %custom313)
  %custom315 = call i32 @llvm.riscv.custom3(i32 %custom314, i32 1)
  %58 = getelementptr inbounds i32, ptr %55, i32 %custom315
  %59 = load i32, ptr %58, align 4
  %60 = load ptr, ptr %3, align 4
  %61 = load i32, ptr %8, align 4
  %62 = load i32, ptr %7, align 4
  %custom316 = call i32 @llvm.riscv.custom3(i32 %61, i32 %62)
  %custom317 = call i32 @llvm.riscv.custom3(i32 %custom316, i32 1)
  %63 = getelementptr inbounds i32, ptr %60, i32 %custom317
  store i32 %59, ptr %63, align 4
  %64 = load i32, ptr %9, align 4
  %65 = load ptr, ptr %3, align 4
  %66 = load i32, ptr %8, align 4
  %67 = load i32, ptr %7, align 4
  %custom318 = call i32 @llvm.riscv.custom3(i32 2, i32 %67)
  %custom319 = call i32 @llvm.riscv.custom3(i32 %66, i32 %custom318)
  %custom320 = call i32 @llvm.riscv.custom3(i32 %custom319, i32 1)
  %68 = getelementptr inbounds i32, ptr %65, i32 %custom320
  %69 = load i32, ptr %68, align 4
  %custom321 = call i32 @llvm.riscv.custom3(i32 %69, i32 %64)
  store i32 %custom321, ptr %68, align 4
  br label %70

70:                                               ; preds = %49
  %71 = load i32, ptr %7, align 4
  %custom322 = call i32 @llvm.riscv.custom3(i32 2, i32 %71)
  %72 = load i32, ptr %8, align 4
  %custom323 = call i32 @llvm.riscv.custom3(i32 %72, i32 %custom322)
  store i32 %custom323, ptr %8, align 4
  br label %45, !llvm.loop !24

73:                                               ; preds = %45
  br label %74

74:                                               ; preds = %73
  %75 = load i32, ptr %7, align 4
  %custom324 = call i32 @llvm.riscv.custom3(i32 %75, i32 1)
  store i32 %custom324, ptr %7, align 4
  br label %41, !llvm.loop !25

76:                                               ; preds = %41
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 4
  %12 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %13

13:                                               ; preds = %53, %0
  %14 = load i32, ptr %2, align 4
  %15 = icmp slt i32 %14, 64
  br i1 %15, label %16, label %55

16:                                               ; preds = %13
  store i32 0, ptr %3, align 4
  br label %17

17:                                               ; preds = %50, %16
  %18 = load i32, ptr %3, align 4
  %19 = icmp slt i32 %18, 64
  br i1 %19, label %20, label %52

20:                                               ; preds = %17
  store i32 0, ptr %4, align 4
  br label %21

21:                                               ; preds = %47, %20
  %22 = load i32, ptr %4, align 4
  %23 = icmp slt i32 %22, 64
  br i1 %23, label %24, label %49

24:                                               ; preds = %21
  %25 = load i32, ptr %2, align 4
  %26 = load i32, ptr %3, align 4
  %custom3 = call i32 @llvm.riscv.custom3(i32 %25, i32 %26)
  %27 = load i32, ptr %4, align 4
  %custom31 = call i32 @llvm.riscv.custom3(i32 %custom3, i32 %27)
  %custom32 = call i32 @llvm.riscv.custom3(i32 %custom31, i32 7)
  %28 = sitofp i32 %custom32 to float
  %29 = fmul float %28, 0x3F847AE140000000
  %30 = load i32, ptr %2, align 4
  %31 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.A, i32 0, i32 %30
  %32 = load i32, ptr %3, align 4
  %33 = getelementptr inbounds [64 x [64 x float]], ptr %31, i32 0, i32 %32
  %34 = load i32, ptr %4, align 4
  %35 = getelementptr inbounds [64 x float], ptr %33, i32 0, i32 %34
  store float %29, ptr %35, align 4
  %36 = load i32, ptr %2, align 4
  %37 = load i32, ptr %3, align 4
  %custom33 = call i32 @llvm.riscv.custom3(i32 %36, i32 %37)
  %38 = load i32, ptr %4, align 4
  %custom34 = call i32 @llvm.riscv.custom3(i32 %custom33, i32 %38)
  %custom35 = call i32 @llvm.riscv.custom3(i32 %custom34, i32 3)
  %39 = sitofp i32 %custom35 to float
  %40 = fmul float %39, 0x3F947AE140000000
  %41 = load i32, ptr %2, align 4
  %42 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.B, i32 0, i32 %41
  %43 = load i32, ptr %3, align 4
  %44 = getelementptr inbounds [64 x [64 x float]], ptr %42, i32 0, i32 %43
  %45 = load i32, ptr %4, align 4
  %46 = getelementptr inbounds [64 x float], ptr %44, i32 0, i32 %45
  store float %40, ptr %46, align 4
  br label %47

47:                                               ; preds = %24
  %48 = load i32, ptr %4, align 4
  %custom36 = call i32 @llvm.riscv.custom3(i32 %48, i32 1)
  store i32 %custom36, ptr %4, align 4
  br label %21, !llvm.loop !26

49:                                               ; preds = %21
  br label %50

50:                                               ; preds = %49
  %51 = load i32, ptr %3, align 4
  %custom37 = call i32 @llvm.riscv.custom3(i32 %51, i32 1)
  store i32 %custom37, ptr %3, align 4
  br label %17, !llvm.loop !27

52:                                               ; preds = %17
  br label %53

53:                                               ; preds = %52
  %54 = load i32, ptr %2, align 4
  %custom38 = call i32 @llvm.riscv.custom3(i32 %54, i32 1)
  store i32 %custom38, ptr %2, align 4
  br label %13, !llvm.loop !28

55:                                               ; preds = %13
  call void @batched_gemm(ptr noundef @main.A, ptr noundef @main.B, ptr noundef @main.C)
  %56 = load float, ptr @main.C, align 4
  %57 = fpext float %56 to double
  %58 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %57)
  store i32 0, ptr %5, align 4
  br label %59

59:                                               ; preds = %88, %55
  %60 = load i32, ptr %5, align 4
  %61 = icmp slt i32 %60, 16
  br i1 %61, label %62, label %90

62:                                               ; preds = %59
  store i32 0, ptr %6, align 4
  br label %63

63:                                               ; preds = %85, %62
  %64 = load i32, ptr %6, align 4
  %65 = icmp slt i32 %64, 5
  br i1 %65, label %66, label %87

66:                                               ; preds = %63
  store i32 0, ptr %7, align 4
  br label %67

67:                                               ; preds = %82, %66
  %68 = load i32, ptr %7, align 4
  %69 = icmp slt i32 %68, 5
  br i1 %69, label %70, label %84

70:                                               ; preds = %67
  %71 = load i32, ptr %5, align 4
  %72 = load i32, ptr %6, align 4
  %custom39 = call i32 @llvm.riscv.custom3(i32 %71, i32 %72)
  %73 = load i32, ptr %7, align 4
  %custom310 = call i32 @llvm.riscv.custom3(i32 %custom39, i32 %73)
  %74 = sitofp i32 %custom310 to float
  %75 = fmul float %74, 0x3F847AE140000000
  %76 = load i32, ptr %5, align 4
  %77 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %76
  %78 = load i32, ptr %6, align 4
  %79 = getelementptr inbounds [5 x [5 x float]], ptr %77, i32 0, i32 %78
  %80 = load i32, ptr %7, align 4
  %81 = getelementptr inbounds [5 x float], ptr %79, i32 0, i32 %80
  store float %75, ptr %81, align 4
  br label %82

82:                                               ; preds = %70
  %83 = load i32, ptr %7, align 4
  %custom311 = call i32 @llvm.riscv.custom3(i32 %83, i32 1)
  store i32 %custom311, ptr %7, align 4
  br label %67, !llvm.loop !29

84:                                               ; preds = %67
  br label %85

85:                                               ; preds = %84
  %86 = load i32, ptr %6, align 4
  %custom312 = call i32 @llvm.riscv.custom3(i32 %86, i32 1)
  store i32 %custom312, ptr %6, align 4
  br label %63, !llvm.loop !30

87:                                               ; preds = %63
  br label %88

88:                                               ; preds = %87
  %89 = load i32, ptr %5, align 4
  %custom313 = call i32 @llvm.riscv.custom3(i32 %89, i32 1)
  store i32 %custom313, ptr %5, align 4
  br label %59, !llvm.loop !31

90:                                               ; preds = %59
  call void @conv2d(ptr noundef @main.IN, ptr noundef @main.Wt, ptr noundef @main.O)
  %91 = load float, ptr @main.O, align 4
  %92 = fpext float %91 to double
  %93 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %92)
  store i32 0, ptr %8, align 4
  br label %94

94:                                               ; preds = %108, %90
  %95 = load i32, ptr %8, align 4
  %96 = icmp slt i32 %95, 4096
  br i1 %96, label %97, label %110

97:                                               ; preds = %94
  %98 = load i32, ptr %8, align 4
  %99 = sitofp i32 %98 to double
  %100 = fmul double 0x4073A28C59D5433B, %99
  %101 = fdiv double %100, 4.096000e+03
  %102 = call double @sin(double noundef %101) #6
  %103 = fptrunc double %102 to float
  %104 = load i32, ptr %8, align 4
  %105 = getelementptr inbounds [4096 x { float, float }], ptr @main.sig, i32 0, i32 %104
  %106 = getelementptr inbounds { float, float }, ptr %105, i32 0, i32 0
  %107 = getelementptr inbounds { float, float }, ptr %105, i32 0, i32 1
  store float %103, ptr %106, align 4
  store float 0.000000e+00, ptr %107, align 4
  br label %108

108:                                              ; preds = %97
  %109 = load i32, ptr %8, align 4
  %custom314 = call i32 @llvm.riscv.custom3(i32 %109, i32 1)
  store i32 %custom314, ptr %8, align 4
  br label %94, !llvm.loop !32

110:                                              ; preds = %94
  call void @fft_4096(ptr noundef @main.sig)
  %111 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1), align 4
  %112 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1, i32 1), align 4
  %113 = fpext float %111 to double
  %114 = fpext float %112 to double
  %115 = fptrunc double %113 to float
  %116 = fpext float %115 to double
  %117 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1), align 4
  %118 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1, i32 1), align 4
  %119 = fpext float %117 to double
  %120 = fpext float %118 to double
  %121 = fptrunc double %120 to float
  %122 = fpext float %121 to double
  %123 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %116, double noundef %122)
  %124 = call noalias ptr @malloc(i32 noundef 16384) #7
  store ptr %124, ptr %9, align 4
  store i32 0, ptr %10, align 4
  br label %125

125:                                              ; preds = %136, %110
  %126 = load i32, ptr %10, align 4
  %127 = icmp slt i32 %126, 4096
  br i1 %127, label %128, label %138

128:                                              ; preds = %125
  %129 = load i32, ptr %10, align 4
  %130 = sitofp i32 %129 to float
  %131 = fdiv float %130, 2.048000e+03
  %132 = fsub float %131, 1.000000e+00
  %133 = load ptr, ptr %9, align 4
  %134 = load i32, ptr %10, align 4
  %135 = getelementptr inbounds float, ptr %133, i32 %134
  store float %132, ptr %135, align 4
  br label %136

136:                                              ; preds = %128
  %137 = load i32, ptr %10, align 4
  %custom315 = call i32 @llvm.riscv.custom3(i32 %137, i32 1)
  store i32 %custom315, ptr %10, align 4
  br label %125, !llvm.loop !33

138:                                              ; preds = %125
  %139 = load ptr, ptr %9, align 4
  call void @gelu_layernorm(ptr noundef %139, i32 noundef 4096)
  %140 = load ptr, ptr %9, align 4
  %141 = getelementptr inbounds float, ptr %140, i32 0
  %142 = load float, ptr %141, align 4
  %143 = fpext float %142 to double
  %144 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, double noundef %143)
  %145 = call noalias ptr @malloc(i32 noundef 16384) #7
  store ptr %145, ptr %11, align 4
  store i32 0, ptr %12, align 4
  br label %146

146:                                              ; preds = %153, %138
  %147 = load i32, ptr %12, align 4
  %148 = icmp slt i32 %147, 4096
  br i1 %148, label %149, label %155

149:                                              ; preds = %146
  %150 = load ptr, ptr %11, align 4
  %151 = load i32, ptr %12, align 4
  %152 = getelementptr inbounds i32, ptr %150, i32 %151
  store i32 1, ptr %152, align 4
  br label %153

153:                                              ; preds = %149
  %154 = load i32, ptr %12, align 4
  %custom316 = call i32 @llvm.riscv.custom3(i32 %154, i32 1)
  store i32 %custom316, ptr %12, align 4
  br label %146, !llvm.loop !34

155:                                              ; preds = %146
  %156 = load ptr, ptr %11, align 4
  call void @prefix_sum(ptr noundef %156, i32 noundef 4096)
  %157 = load ptr, ptr %11, align 4
  %158 = getelementptr inbounds i32, ptr %157, i32 4095
  %159 = load i32, ptr %158, align 4
  %160 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef 4095, i32 noundef %159)
  %161 = load ptr, ptr %9, align 4
  call void @free(ptr noundef %161)
  %162 = load ptr, ptr %11, align 4
  call void @free(ptr noundef %162)
  ret i32 0
}

declare dso_local i32 @printf(ptr noundef, ...) #3

; Function Attrs: nounwind
declare dso_local double @sin(double noundef) #2

; Function Attrs: allocsize(0)
declare dso_local noalias ptr @malloc(i32 noundef) #4

declare dso_local void @free(ptr noundef) #3

; Function Attrs: nounwind memory(none)
declare i32 @llvm.riscv.custom3(i32, i32) #5

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "no-trapping-math"="true" "offload.target"="custom-accel" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { nounwind memory(none) }
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
!16 = !{!"branch_weights", i32 1, i32 1048575}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
!24 = distinct !{!24, !7}
!25 = distinct !{!25, !7}
!26 = distinct !{!26, !7}
!27 = distinct !{!27, !7}
!28 = distinct !{!28, !7}
!29 = distinct !{!29, !7}
!30 = distinct !{!30, !7}
!31 = distinct !{!31, !7}
!32 = distinct !{!32, !7}
!33 = distinct !{!33, !7}
!34 = distinct !{!34, !7}
