; ModuleID = 'heavy_ops.c'
source_filename = "heavy_ops.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.A = internal global [64 x [64 x [64 x float]]] zeroinitializer, align 16
@main.B = internal global [64 x [64 x [64 x float]]] zeroinitializer, align 16
@main.C = internal global [64 x [64 x [64 x float]]] zeroinitializer, align 16
@.str = private unnamed_addr constant [15 x i8] c"C[0][0][0]=%f\0A\00", align 1
@main.IN = internal global [16 x [36 x [36 x float]]] zeroinitializer, align 16
@main.Wt = internal global [16 x [5 x [5 x float]]] zeroinitializer, align 16
@main.O = internal global [32 x [32 x float]] zeroinitializer, align 16
@.str.1 = private unnamed_addr constant [12 x i8] c"O[0][0]=%f\0A\00", align 1
@main.sig = internal global [4096 x { float, float }] zeroinitializer, align 16
@.str.2 = private unnamed_addr constant [15 x i8] c"FFT[1]=%f%+fi\0A\00", align 1
@.str.3 = private unnamed_addr constant [11 x i8] c"vec[0]=%f\0A\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"scan[%d]=%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @batched_gemm(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca float, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %12

12:                                               ; preds = %75, %3
  %13 = load i32, ptr %7, align 4
  %14 = icmp slt i32 %13, 64
  br i1 %14, label %15, label %78

15:                                               ; preds = %12
  store i32 0, ptr %8, align 4
  br label %16

16:                                               ; preds = %71, %15
  %17 = load i32, ptr %8, align 4
  %18 = icmp slt i32 %17, 64
  br i1 %18, label %19, label %74

19:                                               ; preds = %16
  store i32 0, ptr %9, align 4
  br label %20

20:                                               ; preds = %67, %19
  %21 = load i32, ptr %9, align 4
  %22 = icmp slt i32 %21, 64
  br i1 %22, label %23, label %70

23:                                               ; preds = %20
  store float 0.000000e+00, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %24

24:                                               ; preds = %52, %23
  %25 = load i32, ptr %11, align 4
  %26 = icmp slt i32 %25, 64
  br i1 %26, label %27, label %55

27:                                               ; preds = %24
  %28 = load ptr, ptr %4, align 8
  %29 = load i32, ptr %7, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [64 x [64 x float]], ptr %28, i64 %30
  %32 = load i32, ptr %8, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [64 x [64 x float]], ptr %31, i64 0, i64 %33
  %35 = load i32, ptr %11, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [64 x float], ptr %34, i64 0, i64 %36
  %38 = load float, ptr %37, align 4
  %39 = load ptr, ptr %5, align 8
  %40 = load i32, ptr %7, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [64 x [64 x float]], ptr %39, i64 %41
  %43 = load i32, ptr %11, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [64 x [64 x float]], ptr %42, i64 0, i64 %44
  %46 = load i32, ptr %9, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [64 x float], ptr %45, i64 0, i64 %47
  %49 = load float, ptr %48, align 4
  %50 = load float, ptr %10, align 4
  %51 = call float @llvm.fmuladd.f32(float %38, float %49, float %50)
  store float %51, ptr %10, align 4
  br label %52

52:                                               ; preds = %27
  %53 = load i32, ptr %11, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %11, align 4
  br label %24, !llvm.loop !6

55:                                               ; preds = %24
  %56 = load float, ptr %10, align 4
  %57 = load ptr, ptr %6, align 8
  %58 = load i32, ptr %7, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [64 x [64 x float]], ptr %57, i64 %59
  %61 = load i32, ptr %8, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [64 x [64 x float]], ptr %60, i64 0, i64 %62
  %64 = load i32, ptr %9, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [64 x float], ptr %63, i64 0, i64 %65
  store float %56, ptr %66, align 4
  br label %67

67:                                               ; preds = %55
  %68 = load i32, ptr %9, align 4
  %69 = add nsw i32 %68, 1
  store i32 %69, ptr %9, align 4
  br label %20, !llvm.loop !8

70:                                               ; preds = %20
  br label %71

71:                                               ; preds = %70
  %72 = load i32, ptr %8, align 4
  %73 = add nsw i32 %72, 1
  store i32 %73, ptr %8, align 4
  br label %16, !llvm.loop !9

74:                                               ; preds = %16
  br label %75

75:                                               ; preds = %74
  %76 = load i32, ptr %7, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, ptr %7, align 4
  br label %12, !llvm.loop !10

78:                                               ; preds = %12
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @conv2d(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca float, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %13

13:                                               ; preds = %85, %3
  %14 = load i32, ptr %7, align 4
  %15 = icmp slt i32 %14, 32
  br i1 %15, label %16, label %88

16:                                               ; preds = %13
  store i32 0, ptr %8, align 4
  br label %17

17:                                               ; preds = %81, %16
  %18 = load i32, ptr %8, align 4
  %19 = icmp slt i32 %18, 32
  br i1 %19, label %20, label %84

20:                                               ; preds = %17
  store float 0.000000e+00, ptr %9, align 4
  store i32 0, ptr %10, align 4
  br label %21

21:                                               ; preds = %69, %20
  %22 = load i32, ptr %10, align 4
  %23 = icmp slt i32 %22, 16
  br i1 %23, label %24, label %72

24:                                               ; preds = %21
  store i32 0, ptr %11, align 4
  br label %25

25:                                               ; preds = %65, %24
  %26 = load i32, ptr %11, align 4
  %27 = icmp slt i32 %26, 5
  br i1 %27, label %28, label %68

28:                                               ; preds = %25
  store i32 0, ptr %12, align 4
  br label %29

29:                                               ; preds = %61, %28
  %30 = load i32, ptr %12, align 4
  %31 = icmp slt i32 %30, 5
  br i1 %31, label %32, label %64

32:                                               ; preds = %29
  %33 = load ptr, ptr %4, align 8
  %34 = load i32, ptr %10, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [36 x [36 x float]], ptr %33, i64 %35
  %37 = load i32, ptr %7, align 4
  %38 = load i32, ptr %11, align 4
  %39 = add nsw i32 %37, %38
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [36 x [36 x float]], ptr %36, i64 0, i64 %40
  %42 = load i32, ptr %8, align 4
  %43 = load i32, ptr %12, align 4
  %44 = add nsw i32 %42, %43
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [36 x float], ptr %41, i64 0, i64 %45
  %47 = load float, ptr %46, align 4
  %48 = load ptr, ptr %5, align 8
  %49 = load i32, ptr %10, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [5 x [5 x float]], ptr %48, i64 %50
  %52 = load i32, ptr %11, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [5 x [5 x float]], ptr %51, i64 0, i64 %53
  %55 = load i32, ptr %12, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [5 x float], ptr %54, i64 0, i64 %56
  %58 = load float, ptr %57, align 4
  %59 = load float, ptr %9, align 4
  %60 = call float @llvm.fmuladd.f32(float %47, float %58, float %59)
  store float %60, ptr %9, align 4
  br label %61

61:                                               ; preds = %32
  %62 = load i32, ptr %12, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %12, align 4
  br label %29, !llvm.loop !11

64:                                               ; preds = %29
  br label %65

65:                                               ; preds = %64
  %66 = load i32, ptr %11, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %11, align 4
  br label %25, !llvm.loop !12

68:                                               ; preds = %25
  br label %69

69:                                               ; preds = %68
  %70 = load i32, ptr %10, align 4
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %10, align 4
  br label %21, !llvm.loop !13

72:                                               ; preds = %21
  %73 = load float, ptr %9, align 4
  %74 = load ptr, ptr %6, align 8
  %75 = load i32, ptr %7, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [32 x float], ptr %74, i64 %76
  %78 = load i32, ptr %8, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds [32 x float], ptr %77, i64 0, i64 %79
  store float %73, ptr %80, align 4
  br label %81

81:                                               ; preds = %72
  %82 = load i32, ptr %8, align 4
  %83 = add nsw i32 %82, 1
  store i32 %83, ptr %8, align 4
  br label %17, !llvm.loop !14

84:                                               ; preds = %17
  br label %85

85:                                               ; preds = %84
  %86 = load i32, ptr %7, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %7, align 4
  br label %13, !llvm.loop !15

88:                                               ; preds = %13
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @fft_4096(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca { float, float }, align 4
  %7 = alloca { double, double }, align 8
  %8 = alloca i32, align 4
  %9 = alloca { float, float }, align 4
  %10 = alloca i32, align 4
  %11 = alloca { float, float }, align 4
  %12 = alloca { float, float }, align 4
  %13 = alloca { float, float }, align 4
  %14 = alloca { float, float }, align 4
  store ptr %0, ptr %2, align 8
  store i32 1, ptr %3, align 4
  br label %15

15:                                               ; preds = %174, %1
  %16 = load i32, ptr %3, align 4
  %17 = icmp sle i32 %16, 12
  br i1 %17, label %18, label %177

18:                                               ; preds = %15
  %19 = load i32, ptr %3, align 4
  %20 = shl i32 1, %19
  store i32 %20, ptr %4, align 4
  %21 = load i32, ptr %4, align 4
  %22 = ashr i32 %21, 1
  store i32 %22, ptr %5, align 4
  %23 = load i32, ptr %5, align 4
  %24 = sitofp i32 %23 to double
  %25 = fdiv double -0.000000e+00, %24
  %26 = fdiv double 0xC00921FB54442D18, %24
  %27 = getelementptr inbounds nuw { double, double }, ptr %7, i32 0, i32 0
  %28 = getelementptr inbounds nuw { double, double }, ptr %7, i32 0, i32 1
  store double %25, ptr %27, align 8
  store double %26, ptr %28, align 8
  %29 = getelementptr inbounds nuw { double, double }, ptr %7, i32 0, i32 0
  %30 = load double, ptr %29, align 8
  %31 = getelementptr inbounds nuw { double, double }, ptr %7, i32 0, i32 1
  %32 = load double, ptr %31, align 8
  %33 = call { double, double } @cexp(double noundef %30, double noundef %32) #6
  %34 = extractvalue { double, double } %33, 0
  %35 = extractvalue { double, double } %33, 1
  %36 = fptrunc double %34 to float
  %37 = fptrunc double %35 to float
  %38 = getelementptr inbounds nuw { float, float }, ptr %6, i32 0, i32 0
  %39 = getelementptr inbounds nuw { float, float }, ptr %6, i32 0, i32 1
  store float %36, ptr %38, align 4
  store float %37, ptr %39, align 4
  store i32 0, ptr %8, align 4
  br label %40

40:                                               ; preds = %169, %18
  %41 = load i32, ptr %8, align 4
  %42 = icmp slt i32 %41, 4096
  br i1 %42, label %43, label %173

43:                                               ; preds = %40
  %44 = getelementptr inbounds nuw { float, float }, ptr %9, i32 0, i32 0
  %45 = getelementptr inbounds nuw { float, float }, ptr %9, i32 0, i32 1
  store float 1.000000e+00, ptr %44, align 4
  store float 0.000000e+00, ptr %45, align 4
  store i32 0, ptr %10, align 4
  br label %46

46:                                               ; preds = %165, %43
  %47 = load i32, ptr %10, align 4
  %48 = load i32, ptr %5, align 4
  %49 = icmp slt i32 %47, %48
  br i1 %49, label %50, label %168

50:                                               ; preds = %46
  %51 = getelementptr inbounds nuw { float, float }, ptr %9, i32 0, i32 0
  %52 = load float, ptr %51, align 4
  %53 = getelementptr inbounds nuw { float, float }, ptr %9, i32 0, i32 1
  %54 = load float, ptr %53, align 4
  %55 = load ptr, ptr %2, align 8
  %56 = load i32, ptr %8, align 4
  %57 = load i32, ptr %10, align 4
  %58 = add nsw i32 %56, %57
  %59 = load i32, ptr %5, align 4
  %60 = add nsw i32 %58, %59
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds { float, float }, ptr %55, i64 %61
  %63 = getelementptr inbounds nuw { float, float }, ptr %62, i32 0, i32 0
  %64 = load float, ptr %63, align 4
  %65 = getelementptr inbounds nuw { float, float }, ptr %62, i32 0, i32 1
  %66 = load float, ptr %65, align 4
  %67 = fmul float %52, %64
  %68 = fmul float %54, %66
  %69 = fmul float %52, %66
  %70 = fmul float %54, %64
  %71 = fsub float %67, %68
  %72 = fadd float %69, %70
  %73 = fcmp uno float %71, %71
  br i1 %73, label %74, label %82, !prof !16

74:                                               ; preds = %50
  %75 = fcmp uno float %72, %72
  br i1 %75, label %76, label %82, !prof !16

76:                                               ; preds = %74
  %77 = call <2 x float> @__mulsc3(float noundef %52, float noundef %54, float noundef %64, float noundef %66) #6
  store <2 x float> %77, ptr %12, align 4
  %78 = getelementptr inbounds nuw { float, float }, ptr %12, i32 0, i32 0
  %79 = load float, ptr %78, align 4
  %80 = getelementptr inbounds nuw { float, float }, ptr %12, i32 0, i32 1
  %81 = load float, ptr %80, align 4
  br label %82

82:                                               ; preds = %76, %74, %50
  %83 = phi float [ %71, %50 ], [ %71, %74 ], [ %79, %76 ]
  %84 = phi float [ %72, %50 ], [ %72, %74 ], [ %81, %76 ]
  %85 = getelementptr inbounds nuw { float, float }, ptr %11, i32 0, i32 0
  %86 = getelementptr inbounds nuw { float, float }, ptr %11, i32 0, i32 1
  store float %83, ptr %85, align 4
  store float %84, ptr %86, align 4
  %87 = load ptr, ptr %2, align 8
  %88 = load i32, ptr %8, align 4
  %89 = load i32, ptr %10, align 4
  %90 = add nsw i32 %88, %89
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds { float, float }, ptr %87, i64 %91
  %93 = getelementptr inbounds nuw { float, float }, ptr %92, i32 0, i32 0
  %94 = load float, ptr %93, align 4
  %95 = getelementptr inbounds nuw { float, float }, ptr %92, i32 0, i32 1
  %96 = load float, ptr %95, align 4
  %97 = getelementptr inbounds nuw { float, float }, ptr %13, i32 0, i32 0
  %98 = getelementptr inbounds nuw { float, float }, ptr %13, i32 0, i32 1
  store float %94, ptr %97, align 4
  store float %96, ptr %98, align 4
  %99 = getelementptr inbounds nuw { float, float }, ptr %13, i32 0, i32 0
  %100 = load float, ptr %99, align 4
  %101 = getelementptr inbounds nuw { float, float }, ptr %13, i32 0, i32 1
  %102 = load float, ptr %101, align 4
  %103 = getelementptr inbounds nuw { float, float }, ptr %11, i32 0, i32 0
  %104 = load float, ptr %103, align 4
  %105 = getelementptr inbounds nuw { float, float }, ptr %11, i32 0, i32 1
  %106 = load float, ptr %105, align 4
  %107 = fadd float %100, %104
  %108 = fadd float %102, %106
  %109 = load ptr, ptr %2, align 8
  %110 = load i32, ptr %8, align 4
  %111 = load i32, ptr %10, align 4
  %112 = add nsw i32 %110, %111
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds { float, float }, ptr %109, i64 %113
  %115 = getelementptr inbounds nuw { float, float }, ptr %114, i32 0, i32 0
  %116 = getelementptr inbounds nuw { float, float }, ptr %114, i32 0, i32 1
  store float %107, ptr %115, align 4
  store float %108, ptr %116, align 4
  %117 = getelementptr inbounds nuw { float, float }, ptr %13, i32 0, i32 0
  %118 = load float, ptr %117, align 4
  %119 = getelementptr inbounds nuw { float, float }, ptr %13, i32 0, i32 1
  %120 = load float, ptr %119, align 4
  %121 = getelementptr inbounds nuw { float, float }, ptr %11, i32 0, i32 0
  %122 = load float, ptr %121, align 4
  %123 = getelementptr inbounds nuw { float, float }, ptr %11, i32 0, i32 1
  %124 = load float, ptr %123, align 4
  %125 = fsub float %118, %122
  %126 = fsub float %120, %124
  %127 = load ptr, ptr %2, align 8
  %128 = load i32, ptr %8, align 4
  %129 = load i32, ptr %10, align 4
  %130 = add nsw i32 %128, %129
  %131 = load i32, ptr %5, align 4
  %132 = add nsw i32 %130, %131
  %133 = sext i32 %132 to i64
  %134 = getelementptr inbounds { float, float }, ptr %127, i64 %133
  %135 = getelementptr inbounds nuw { float, float }, ptr %134, i32 0, i32 0
  %136 = getelementptr inbounds nuw { float, float }, ptr %134, i32 0, i32 1
  store float %125, ptr %135, align 4
  store float %126, ptr %136, align 4
  %137 = getelementptr inbounds nuw { float, float }, ptr %6, i32 0, i32 0
  %138 = load float, ptr %137, align 4
  %139 = getelementptr inbounds nuw { float, float }, ptr %6, i32 0, i32 1
  %140 = load float, ptr %139, align 4
  %141 = getelementptr inbounds nuw { float, float }, ptr %9, i32 0, i32 0
  %142 = load float, ptr %141, align 4
  %143 = getelementptr inbounds nuw { float, float }, ptr %9, i32 0, i32 1
  %144 = load float, ptr %143, align 4
  %145 = fmul float %142, %138
  %146 = fmul float %144, %140
  %147 = fmul float %142, %140
  %148 = fmul float %144, %138
  %149 = fsub float %145, %146
  %150 = fadd float %147, %148
  %151 = fcmp uno float %149, %149
  br i1 %151, label %152, label %160, !prof !16

152:                                              ; preds = %82
  %153 = fcmp uno float %150, %150
  br i1 %153, label %154, label %160, !prof !16

154:                                              ; preds = %152
  %155 = call <2 x float> @__mulsc3(float noundef %142, float noundef %144, float noundef %138, float noundef %140) #6
  store <2 x float> %155, ptr %14, align 4
  %156 = getelementptr inbounds nuw { float, float }, ptr %14, i32 0, i32 0
  %157 = load float, ptr %156, align 4
  %158 = getelementptr inbounds nuw { float, float }, ptr %14, i32 0, i32 1
  %159 = load float, ptr %158, align 4
  br label %160

160:                                              ; preds = %154, %152, %82
  %161 = phi float [ %149, %82 ], [ %149, %152 ], [ %157, %154 ]
  %162 = phi float [ %150, %82 ], [ %150, %152 ], [ %159, %154 ]
  %163 = getelementptr inbounds nuw { float, float }, ptr %9, i32 0, i32 0
  %164 = getelementptr inbounds nuw { float, float }, ptr %9, i32 0, i32 1
  store float %161, ptr %163, align 4
  store float %162, ptr %164, align 4
  br label %165

165:                                              ; preds = %160
  %166 = load i32, ptr %10, align 4
  %167 = add nsw i32 %166, 1
  store i32 %167, ptr %10, align 4
  br label %46, !llvm.loop !17

168:                                              ; preds = %46
  br label %169

169:                                              ; preds = %168
  %170 = load i32, ptr %4, align 4
  %171 = load i32, ptr %8, align 4
  %172 = add nsw i32 %171, %170
  store i32 %172, ptr %8, align 4
  br label %40, !llvm.loop !18

173:                                              ; preds = %40
  br label %174

174:                                              ; preds = %173
  %175 = load i32, ptr %3, align 4
  %176 = add nsw i32 %175, 1
  store i32 %176, ptr %3, align 4
  br label %15, !llvm.loop !19

177:                                              ; preds = %15
  ret void
}

; Function Attrs: nounwind
declare { double, double } @cexp(double noundef, double noundef) #3

declare <2 x float> @__mulsc3(float, float, float, float)

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @gelu_layernorm(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
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
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store double 0.000000e+00, ptr %5, align 8
  store double 0.000000e+00, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %14

14:                                               ; preds = %52, %2
  %15 = load i32, ptr %7, align 4
  %16 = load i32, ptr %4, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %55

18:                                               ; preds = %14
  %19 = load ptr, ptr %3, align 8
  %20 = load i32, ptr %7, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds float, ptr %19, i64 %21
  %23 = load float, ptr %22, align 4
  store float %23, ptr %8, align 4
  %24 = load float, ptr %8, align 4
  %25 = fmul float 5.000000e-01, %24
  %26 = load float, ptr %8, align 4
  %27 = load float, ptr %8, align 4
  %28 = fmul float 0x3FA6E4E260000000, %27
  %29 = load float, ptr %8, align 4
  %30 = fmul float %28, %29
  %31 = load float, ptr %8, align 4
  %32 = call float @llvm.fmuladd.f32(float %30, float %31, float %26)
  %33 = fmul float 0x3FE9884540000000, %32
  %34 = call float @tanhf(float noundef %33) #6
  %35 = fadd float 1.000000e+00, %34
  %36 = fmul float %25, %35
  store float %36, ptr %9, align 4
  %37 = load float, ptr %9, align 4
  %38 = load ptr, ptr %3, align 8
  %39 = load i32, ptr %7, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds float, ptr %38, i64 %40
  store float %37, ptr %41, align 4
  %42 = load float, ptr %9, align 4
  %43 = fpext float %42 to double
  %44 = load double, ptr %5, align 8
  %45 = fadd double %44, %43
  store double %45, ptr %5, align 8
  %46 = load float, ptr %9, align 4
  %47 = load float, ptr %9, align 4
  %48 = fmul float %46, %47
  %49 = fpext float %48 to double
  %50 = load double, ptr %6, align 8
  %51 = fadd double %50, %49
  store double %51, ptr %6, align 8
  br label %52

52:                                               ; preds = %18
  %53 = load i32, ptr %7, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %7, align 4
  br label %14, !llvm.loop !20

55:                                               ; preds = %14
  %56 = load double, ptr %5, align 8
  %57 = load i32, ptr %4, align 4
  %58 = sitofp i32 %57 to double
  %59 = fdiv double %56, %58
  store double %59, ptr %10, align 8
  %60 = load double, ptr %6, align 8
  %61 = load i32, ptr %4, align 4
  %62 = sitofp i32 %61 to double
  %63 = fdiv double %60, %62
  %64 = load double, ptr %10, align 8
  %65 = load double, ptr %10, align 8
  %66 = fneg double %64
  %67 = call double @llvm.fmuladd.f64(double %66, double %65, double %63)
  %68 = fadd double %67, 1.000000e-05
  store double %68, ptr %11, align 8
  %69 = load double, ptr %11, align 8
  %70 = call double @sqrt(double noundef %69) #6
  %71 = fdiv double 1.000000e+00, %70
  store double %71, ptr %12, align 8
  store i32 0, ptr %13, align 4
  br label %72

72:                                               ; preds = %92, %55
  %73 = load i32, ptr %13, align 4
  %74 = load i32, ptr %4, align 4
  %75 = icmp slt i32 %73, %74
  br i1 %75, label %76, label %95

76:                                               ; preds = %72
  %77 = load ptr, ptr %3, align 8
  %78 = load i32, ptr %13, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds float, ptr %77, i64 %79
  %81 = load float, ptr %80, align 4
  %82 = fpext float %81 to double
  %83 = load double, ptr %10, align 8
  %84 = fsub double %82, %83
  %85 = load double, ptr %12, align 8
  %86 = fmul double %84, %85
  %87 = fptrunc double %86 to float
  %88 = load ptr, ptr %3, align 8
  %89 = load i32, ptr %13, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds float, ptr %88, i64 %90
  store float %87, ptr %91, align 4
  br label %92

92:                                               ; preds = %76
  %93 = load i32, ptr %13, align 4
  %94 = add nsw i32 %93, 1
  store i32 %94, ptr %13, align 4
  br label %72, !llvm.loop !21

95:                                               ; preds = %72
  ret void
}

; Function Attrs: nounwind
declare float @tanhf(float noundef) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nounwind
declare double @sqrt(double noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @prefix_sum(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 1, ptr %5, align 4
  br label %10

10:                                               ; preds = %44, %2
  %11 = load i32, ptr %5, align 4
  %12 = load i32, ptr %4, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %47

14:                                               ; preds = %10
  store i32 0, ptr %6, align 4
  br label %15

15:                                               ; preds = %38, %14
  %16 = load i32, ptr %6, align 4
  %17 = load i32, ptr %4, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %43

19:                                               ; preds = %15
  %20 = load ptr, ptr %3, align 8
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %5, align 4
  %23 = add nsw i32 %21, %22
  %24 = sub nsw i32 %23, 1
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i32, ptr %20, i64 %25
  %27 = load i32, ptr %26, align 4
  %28 = load ptr, ptr %3, align 8
  %29 = load i32, ptr %6, align 4
  %30 = load i32, ptr %5, align 4
  %31 = mul nsw i32 2, %30
  %32 = add nsw i32 %29, %31
  %33 = sub nsw i32 %32, 1
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds i32, ptr %28, i64 %34
  %36 = load i32, ptr %35, align 4
  %37 = add nsw i32 %36, %27
  store i32 %37, ptr %35, align 4
  br label %38

38:                                               ; preds = %19
  %39 = load i32, ptr %5, align 4
  %40 = mul nsw i32 2, %39
  %41 = load i32, ptr %6, align 4
  %42 = add nsw i32 %41, %40
  store i32 %42, ptr %6, align 4
  br label %15, !llvm.loop !22

43:                                               ; preds = %15
  br label %44

44:                                               ; preds = %43
  %45 = load i32, ptr %5, align 4
  %46 = shl i32 %45, 1
  store i32 %46, ptr %5, align 4
  br label %10, !llvm.loop !23

47:                                               ; preds = %10
  %48 = load ptr, ptr %3, align 8
  %49 = load i32, ptr %4, align 4
  %50 = sub nsw i32 %49, 1
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds i32, ptr %48, i64 %51
  store i32 0, ptr %52, align 4
  %53 = load i32, ptr %4, align 4
  %54 = ashr i32 %53, 1
  store i32 %54, ptr %7, align 4
  br label %55

55:                                               ; preds = %105, %47
  %56 = load i32, ptr %7, align 4
  %57 = icmp sge i32 %56, 1
  br i1 %57, label %58, label %108

58:                                               ; preds = %55
  store i32 0, ptr %8, align 4
  br label %59

59:                                               ; preds = %99, %58
  %60 = load i32, ptr %8, align 4
  %61 = load i32, ptr %4, align 4
  %62 = icmp slt i32 %60, %61
  br i1 %62, label %63, label %104

63:                                               ; preds = %59
  %64 = load ptr, ptr %3, align 8
  %65 = load i32, ptr %8, align 4
  %66 = load i32, ptr %7, align 4
  %67 = add nsw i32 %65, %66
  %68 = sub nsw i32 %67, 1
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds i32, ptr %64, i64 %69
  %71 = load i32, ptr %70, align 4
  store i32 %71, ptr %9, align 4
  %72 = load ptr, ptr %3, align 8
  %73 = load i32, ptr %8, align 4
  %74 = load i32, ptr %7, align 4
  %75 = mul nsw i32 2, %74
  %76 = add nsw i32 %73, %75
  %77 = sub nsw i32 %76, 1
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds i32, ptr %72, i64 %78
  %80 = load i32, ptr %79, align 4
  %81 = load ptr, ptr %3, align 8
  %82 = load i32, ptr %8, align 4
  %83 = load i32, ptr %7, align 4
  %84 = add nsw i32 %82, %83
  %85 = sub nsw i32 %84, 1
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds i32, ptr %81, i64 %86
  store i32 %80, ptr %87, align 4
  %88 = load i32, ptr %9, align 4
  %89 = load ptr, ptr %3, align 8
  %90 = load i32, ptr %8, align 4
  %91 = load i32, ptr %7, align 4
  %92 = mul nsw i32 2, %91
  %93 = add nsw i32 %90, %92
  %94 = sub nsw i32 %93, 1
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds i32, ptr %89, i64 %95
  %97 = load i32, ptr %96, align 4
  %98 = add nsw i32 %97, %88
  store i32 %98, ptr %96, align 4
  br label %99

99:                                               ; preds = %63
  %100 = load i32, ptr %7, align 4
  %101 = mul nsw i32 2, %100
  %102 = load i32, ptr %8, align 4
  %103 = add nsw i32 %102, %101
  store i32 %103, ptr %8, align 4
  br label %59, !llvm.loop !24

104:                                              ; preds = %59
  br label %105

105:                                              ; preds = %104
  %106 = load i32, ptr %7, align 4
  %107 = ashr i32 %106, 1
  store i32 %107, ptr %7, align 4
  br label %55, !llvm.loop !25

108:                                              ; preds = %55
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @batched_gemm_accel(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i64 1073741824, ptr %7, align 8
  store i64 1074003968, ptr %8, align 8
  store i64 1074266112, ptr %9, align 8
  store i64 1048576, ptr %10, align 8
  %11 = load ptr, ptr %4, align 8
  %12 = ptrtoint ptr %11 to i64
  %13 = load i64, ptr %10, align 8
  %14 = trunc i64 %13 to i32
  call void @dma_kick(i64 noundef %12, i64 noundef 1073741824, i32 noundef %14, i32 noundef 0)
  %15 = load ptr, ptr %5, align 8
  %16 = ptrtoint ptr %15 to i64
  %17 = load i64, ptr %10, align 8
  %18 = trunc i64 %17 to i32
  call void @dma_kick(i64 noundef %16, i64 noundef 1074003968, i32 noundef %18, i32 noundef 0)
  call void @dma_wait()
  call void asm sideeffect ".insn r 0x7b, 0, 0, x0, $0, $1", "r,r,~{memory},~{dirflag},~{fpsr},~{flags}"(i64 1073741824, i64 1074003968) #6, !srcloc !26
  %19 = load ptr, ptr %6, align 8
  %20 = ptrtoint ptr %19 to i64
  %21 = load i64, ptr %10, align 8
  %22 = trunc i64 %21 to i32
  call void @dma_kick(i64 noundef %20, i64 noundef 1074266112, i32 noundef %22, i32 noundef 1)
  call void @dma_wait()
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @dma_kick(i64 noundef %0, i64 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  store i64 %0, ptr %5, align 8
  store i64 %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  store ptr inttoptr (i64 1342177280 to ptr), ptr %9, align 8
  store ptr inttoptr (i64 1342177284 to ptr), ptr %10, align 8
  store ptr inttoptr (i64 1342177288 to ptr), ptr %11, align 8
  store ptr inttoptr (i64 1342177292 to ptr), ptr %12, align 8
  %13 = load i32, ptr %8, align 4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %17

15:                                               ; preds = %4
  %16 = load i64, ptr %6, align 8
  br label %19

17:                                               ; preds = %4
  %18 = load i64, ptr %5, align 8
  br label %19

19:                                               ; preds = %17, %15
  %20 = phi i64 [ %16, %15 ], [ %18, %17 ]
  %21 = trunc i64 %20 to i32
  %22 = load ptr, ptr %9, align 8
  store volatile i32 %21, ptr %22, align 4
  %23 = load i32, ptr %8, align 4
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %27

25:                                               ; preds = %19
  %26 = load i64, ptr %5, align 8
  br label %29

27:                                               ; preds = %19
  %28 = load i64, ptr %6, align 8
  br label %29

29:                                               ; preds = %27, %25
  %30 = phi i64 [ %26, %25 ], [ %28, %27 ]
  %31 = trunc i64 %30 to i32
  %32 = load ptr, ptr %10, align 8
  store volatile i32 %31, ptr %32, align 4
  %33 = load i32, ptr %7, align 4
  %34 = load ptr, ptr %11, align 8
  store volatile i32 %33, ptr %34, align 4
  %35 = load ptr, ptr %12, align 8
  store volatile i32 1, ptr %35, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @dma_wait() #0 {
  %1 = alloca ptr, align 8
  store ptr inttoptr (i64 1342177296 to ptr), ptr %1, align 8
  br label %2

2:                                                ; preds = %8, %0
  %3 = load ptr, ptr %1, align 8
  %4 = load volatile i32, ptr %3, align 4
  %5 = and i32 %4, 1
  %6 = icmp ne i32 %5, 0
  %7 = xor i1 %6, true
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  br label %2, !llvm.loop !27

9:                                                ; preds = %2
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
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %13

13:                                               ; preds = %67, %0
  %14 = load i32, ptr %2, align 4
  %15 = icmp slt i32 %14, 64
  br i1 %15, label %16, label %70

16:                                               ; preds = %13
  store i32 0, ptr %3, align 4
  br label %17

17:                                               ; preds = %63, %16
  %18 = load i32, ptr %3, align 4
  %19 = icmp slt i32 %18, 64
  br i1 %19, label %20, label %66

20:                                               ; preds = %17
  store i32 0, ptr %4, align 4
  br label %21

21:                                               ; preds = %59, %20
  %22 = load i32, ptr %4, align 4
  %23 = icmp slt i32 %22, 64
  br i1 %23, label %24, label %62

24:                                               ; preds = %21
  %25 = load i32, ptr %2, align 4
  %26 = load i32, ptr %3, align 4
  %27 = add nsw i32 %25, %26
  %28 = load i32, ptr %4, align 4
  %29 = add nsw i32 %27, %28
  %30 = and i32 %29, 7
  %31 = sitofp i32 %30 to float
  %32 = fmul float %31, 0x3F847AE140000000
  %33 = load i32, ptr %2, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.A, i64 0, i64 %34
  %36 = load i32, ptr %3, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [64 x [64 x float]], ptr %35, i64 0, i64 %37
  %39 = load i32, ptr %4, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [64 x float], ptr %38, i64 0, i64 %40
  store float %32, ptr %41, align 4
  %42 = load i32, ptr %2, align 4
  %43 = load i32, ptr %3, align 4
  %44 = sub nsw i32 %42, %43
  %45 = load i32, ptr %4, align 4
  %46 = add nsw i32 %44, %45
  %47 = and i32 %46, 3
  %48 = sitofp i32 %47 to float
  %49 = fmul float %48, 0x3F947AE140000000
  %50 = load i32, ptr %2, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.B, i64 0, i64 %51
  %53 = load i32, ptr %3, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [64 x [64 x float]], ptr %52, i64 0, i64 %54
  %56 = load i32, ptr %4, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [64 x float], ptr %55, i64 0, i64 %57
  store float %49, ptr %58, align 4
  br label %59

59:                                               ; preds = %24
  %60 = load i32, ptr %4, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %4, align 4
  br label %21, !llvm.loop !28

62:                                               ; preds = %21
  br label %63

63:                                               ; preds = %62
  %64 = load i32, ptr %3, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, ptr %3, align 4
  br label %17, !llvm.loop !29

66:                                               ; preds = %17
  br label %67

67:                                               ; preds = %66
  %68 = load i32, ptr %2, align 4
  %69 = add nsw i32 %68, 1
  store i32 %69, ptr %2, align 4
  br label %13, !llvm.loop !30

70:                                               ; preds = %13
  call void @batched_gemm_accel(ptr noundef @main.A, ptr noundef @main.B, ptr noundef @main.C)
  %71 = load float, ptr @main.C, align 16
  %72 = fpext float %71 to double
  %73 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %72)
  store i32 0, ptr %5, align 4
  br label %74

74:                                               ; preds = %110, %70
  %75 = load i32, ptr %5, align 4
  %76 = icmp slt i32 %75, 16
  br i1 %76, label %77, label %113

77:                                               ; preds = %74
  store i32 0, ptr %6, align 4
  br label %78

78:                                               ; preds = %106, %77
  %79 = load i32, ptr %6, align 4
  %80 = icmp slt i32 %79, 5
  br i1 %80, label %81, label %109

81:                                               ; preds = %78
  store i32 0, ptr %7, align 4
  br label %82

82:                                               ; preds = %102, %81
  %83 = load i32, ptr %7, align 4
  %84 = icmp slt i32 %83, 5
  br i1 %84, label %85, label %105

85:                                               ; preds = %82
  %86 = load i32, ptr %5, align 4
  %87 = load i32, ptr %6, align 4
  %88 = add nsw i32 %86, %87
  %89 = load i32, ptr %7, align 4
  %90 = add nsw i32 %88, %89
  %91 = sitofp i32 %90 to float
  %92 = fmul float %91, 0x3F847AE140000000
  %93 = load i32, ptr %5, align 4
  %94 = sext i32 %93 to i64
  %95 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i64 0, i64 %94
  %96 = load i32, ptr %6, align 4
  %97 = sext i32 %96 to i64
  %98 = getelementptr inbounds [5 x [5 x float]], ptr %95, i64 0, i64 %97
  %99 = load i32, ptr %7, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds [5 x float], ptr %98, i64 0, i64 %100
  store float %92, ptr %101, align 4
  br label %102

102:                                              ; preds = %85
  %103 = load i32, ptr %7, align 4
  %104 = add nsw i32 %103, 1
  store i32 %104, ptr %7, align 4
  br label %82, !llvm.loop !31

105:                                              ; preds = %82
  br label %106

106:                                              ; preds = %105
  %107 = load i32, ptr %6, align 4
  %108 = add nsw i32 %107, 1
  store i32 %108, ptr %6, align 4
  br label %78, !llvm.loop !32

109:                                              ; preds = %78
  br label %110

110:                                              ; preds = %109
  %111 = load i32, ptr %5, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, ptr %5, align 4
  br label %74, !llvm.loop !33

113:                                              ; preds = %74
  call void @conv2d(ptr noundef @main.IN, ptr noundef @main.Wt, ptr noundef @main.O)
  %114 = load float, ptr @main.O, align 16
  %115 = fpext float %114 to double
  %116 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %115)
  store i32 0, ptr %8, align 4
  br label %117

117:                                              ; preds = %132, %113
  %118 = load i32, ptr %8, align 4
  %119 = icmp slt i32 %118, 4096
  br i1 %119, label %120, label %135

120:                                              ; preds = %117
  %121 = load i32, ptr %8, align 4
  %122 = sitofp i32 %121 to double
  %123 = fmul double 0x4073A28C59D5433B, %122
  %124 = fdiv double %123, 4.096000e+03
  %125 = call double @sin(double noundef %124) #6
  %126 = fptrunc double %125 to float
  %127 = load i32, ptr %8, align 4
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds [4096 x { float, float }], ptr @main.sig, i64 0, i64 %128
  %130 = getelementptr inbounds nuw { float, float }, ptr %129, i32 0, i32 0
  %131 = getelementptr inbounds nuw { float, float }, ptr %129, i32 0, i32 1
  store float %126, ptr %130, align 8
  store float 0.000000e+00, ptr %131, align 4
  br label %132

132:                                              ; preds = %120
  %133 = load i32, ptr %8, align 4
  %134 = add nsw i32 %133, 1
  store i32 %134, ptr %8, align 4
  br label %117, !llvm.loop !34

135:                                              ; preds = %117
  call void @fft_4096(ptr noundef @main.sig)
  %136 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i64 0, i64 1), align 8
  %137 = load float, ptr getelementptr inbounds nuw ({ float, float }, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i64 0, i64 1), i32 0, i32 1), align 4
  %138 = fpext float %136 to double
  %139 = fpext float %137 to double
  %140 = fptrunc double %138 to float
  %141 = fpext float %140 to double
  %142 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i64 0, i64 1), align 8
  %143 = load float, ptr getelementptr inbounds nuw ({ float, float }, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i64 0, i64 1), i32 0, i32 1), align 4
  %144 = fpext float %142 to double
  %145 = fpext float %143 to double
  %146 = fptrunc double %145 to float
  %147 = fpext float %146 to double
  %148 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %141, double noundef %147)
  %149 = call noalias ptr @malloc(i64 noundef 16384) #7
  store ptr %149, ptr %9, align 8
  store i32 0, ptr %10, align 4
  br label %150

150:                                              ; preds = %162, %135
  %151 = load i32, ptr %10, align 4
  %152 = icmp slt i32 %151, 4096
  br i1 %152, label %153, label %165

153:                                              ; preds = %150
  %154 = load i32, ptr %10, align 4
  %155 = sitofp i32 %154 to float
  %156 = fdiv float %155, 2.048000e+03
  %157 = fsub float %156, 1.000000e+00
  %158 = load ptr, ptr %9, align 8
  %159 = load i32, ptr %10, align 4
  %160 = sext i32 %159 to i64
  %161 = getelementptr inbounds float, ptr %158, i64 %160
  store float %157, ptr %161, align 4
  br label %162

162:                                              ; preds = %153
  %163 = load i32, ptr %10, align 4
  %164 = add nsw i32 %163, 1
  store i32 %164, ptr %10, align 4
  br label %150, !llvm.loop !35

165:                                              ; preds = %150
  %166 = load ptr, ptr %9, align 8
  call void @gelu_layernorm(ptr noundef %166, i32 noundef 4096)
  %167 = load ptr, ptr %9, align 8
  %168 = getelementptr inbounds float, ptr %167, i64 0
  %169 = load float, ptr %168, align 4
  %170 = fpext float %169 to double
  %171 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, double noundef %170)
  %172 = call noalias ptr @malloc(i64 noundef 16384) #7
  store ptr %172, ptr %11, align 8
  store i32 0, ptr %12, align 4
  br label %173

173:                                              ; preds = %181, %165
  %174 = load i32, ptr %12, align 4
  %175 = icmp slt i32 %174, 4096
  br i1 %175, label %176, label %184

176:                                              ; preds = %173
  %177 = load ptr, ptr %11, align 8
  %178 = load i32, ptr %12, align 4
  %179 = sext i32 %178 to i64
  %180 = getelementptr inbounds i32, ptr %177, i64 %179
  store i32 1, ptr %180, align 4
  br label %181

181:                                              ; preds = %176
  %182 = load i32, ptr %12, align 4
  %183 = add nsw i32 %182, 1
  store i32 %183, ptr %12, align 4
  br label %173, !llvm.loop !36

184:                                              ; preds = %173
  %185 = load ptr, ptr %11, align 8
  call void @prefix_sum(ptr noundef %185, i32 noundef 4096)
  %186 = load ptr, ptr %11, align 8
  %187 = getelementptr inbounds i32, ptr %186, i64 4095
  %188 = load i32, ptr %187, align 4
  %189 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef 4095, i32 noundef %188)
  %190 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %190) #6
  %191 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %191) #6
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #4

; Function Attrs: nounwind
declare double @sin(double noundef) #3

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #5

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="64" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }
attributes #7 = { nounwind allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 21.0.0git (https://github.com/llvm/llvm-project.git 8e104d69fc4a7fa6e93fd543208f184628d1d2ae)"}
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
!26 = !{i64 3229}
!27 = distinct !{!27, !7}
!28 = distinct !{!28, !7}
!29 = distinct !{!29, !7}
!30 = distinct !{!30, !7}
!31 = distinct !{!31, !7}
!32 = distinct !{!32, !7}
!33 = distinct !{!33, !7}
!34 = distinct !{!34, !7}
!35 = distinct !{!35, !7}
!36 = distinct !{!36, !7}
