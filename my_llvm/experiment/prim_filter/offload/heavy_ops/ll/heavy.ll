; ModuleID = 'heavy_ops.c'
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

12:                                               ; preds = %66, %3
  %13 = load i32, ptr %7, align 4
  %14 = icmp slt i32 %13, 64
  br i1 %14, label %15, label %69

15:                                               ; preds = %12
  store i32 0, ptr %8, align 4
  br label %16

16:                                               ; preds = %62, %15
  %17 = load i32, ptr %8, align 4
  %18 = icmp slt i32 %17, 64
  br i1 %18, label %19, label %65

19:                                               ; preds = %16
  store i32 0, ptr %9, align 4
  br label %20

20:                                               ; preds = %58, %19
  %21 = load i32, ptr %9, align 4
  %22 = icmp slt i32 %21, 64
  br i1 %22, label %23, label %61

23:                                               ; preds = %20
  store float 0.000000e+00, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %24

24:                                               ; preds = %46, %23
  %25 = load i32, ptr %11, align 4
  %26 = icmp slt i32 %25, 64
  br i1 %26, label %27, label %49

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
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %11, align 4
  br label %24, !llvm.loop !6

49:                                               ; preds = %24
  %50 = load float, ptr %10, align 4
  %51 = load ptr, ptr %6, align 4
  %52 = load i32, ptr %7, align 4
  %53 = getelementptr inbounds [64 x [64 x float]], ptr %51, i32 %52
  %54 = load i32, ptr %8, align 4
  %55 = getelementptr inbounds [64 x [64 x float]], ptr %53, i32 0, i32 %54
  %56 = load i32, ptr %9, align 4
  %57 = getelementptr inbounds [64 x float], ptr %55, i32 0, i32 %56
  store float %50, ptr %57, align 4
  br label %58

58:                                               ; preds = %49
  %59 = load i32, ptr %9, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %9, align 4
  br label %20, !llvm.loop !8

61:                                               ; preds = %20
  br label %62

62:                                               ; preds = %61
  %63 = load i32, ptr %8, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, ptr %8, align 4
  br label %16, !llvm.loop !9

65:                                               ; preds = %16
  br label %66

66:                                               ; preds = %65
  %67 = load i32, ptr %7, align 4
  %68 = add nsw i32 %67, 1
  store i32 %68, ptr %7, align 4
  br label %12, !llvm.loop !10

69:                                               ; preds = %12
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

13:                                               ; preds = %77, %3
  %14 = load i32, ptr %7, align 4
  %15 = icmp slt i32 %14, 32
  br i1 %15, label %16, label %80

16:                                               ; preds = %13
  store i32 0, ptr %8, align 4
  br label %17

17:                                               ; preds = %73, %16
  %18 = load i32, ptr %8, align 4
  %19 = icmp slt i32 %18, 32
  br i1 %19, label %20, label %76

20:                                               ; preds = %17
  store float 0.000000e+00, ptr %9, align 4
  store i32 0, ptr %10, align 4
  br label %21

21:                                               ; preds = %63, %20
  %22 = load i32, ptr %10, align 4
  %23 = icmp slt i32 %22, 16
  br i1 %23, label %24, label %66

24:                                               ; preds = %21
  store i32 0, ptr %11, align 4
  br label %25

25:                                               ; preds = %59, %24
  %26 = load i32, ptr %11, align 4
  %27 = icmp slt i32 %26, 5
  br i1 %27, label %28, label %62

28:                                               ; preds = %25
  store i32 0, ptr %12, align 4
  br label %29

29:                                               ; preds = %55, %28
  %30 = load i32, ptr %12, align 4
  %31 = icmp slt i32 %30, 5
  br i1 %31, label %32, label %58

32:                                               ; preds = %29
  %33 = load ptr, ptr %4, align 4
  %34 = load i32, ptr %10, align 4
  %35 = getelementptr inbounds [36 x [36 x float]], ptr %33, i32 %34
  %36 = load i32, ptr %7, align 4
  %37 = load i32, ptr %11, align 4
  %38 = add nsw i32 %36, %37
  %39 = getelementptr inbounds [36 x [36 x float]], ptr %35, i32 0, i32 %38
  %40 = load i32, ptr %8, align 4
  %41 = load i32, ptr %12, align 4
  %42 = add nsw i32 %40, %41
  %43 = getelementptr inbounds [36 x float], ptr %39, i32 0, i32 %42
  %44 = load float, ptr %43, align 4
  %45 = load ptr, ptr %5, align 4
  %46 = load i32, ptr %10, align 4
  %47 = getelementptr inbounds [5 x [5 x float]], ptr %45, i32 %46
  %48 = load i32, ptr %11, align 4
  %49 = getelementptr inbounds [5 x [5 x float]], ptr %47, i32 0, i32 %48
  %50 = load i32, ptr %12, align 4
  %51 = getelementptr inbounds [5 x float], ptr %49, i32 0, i32 %50
  %52 = load float, ptr %51, align 4
  %53 = load float, ptr %9, align 4
  %54 = call float @llvm.fmuladd.f32(float %44, float %52, float %53)
  store float %54, ptr %9, align 4
  br label %55

55:                                               ; preds = %32
  %56 = load i32, ptr %12, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %12, align 4
  br label %29, !llvm.loop !11

58:                                               ; preds = %29
  br label %59

59:                                               ; preds = %58
  %60 = load i32, ptr %11, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %11, align 4
  br label %25, !llvm.loop !12

62:                                               ; preds = %25
  br label %63

63:                                               ; preds = %62
  %64 = load i32, ptr %10, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, ptr %10, align 4
  br label %21, !llvm.loop !13

66:                                               ; preds = %21
  %67 = load float, ptr %9, align 4
  %68 = load ptr, ptr %6, align 4
  %69 = load i32, ptr %7, align 4
  %70 = getelementptr inbounds [32 x float], ptr %68, i32 %69
  %71 = load i32, ptr %8, align 4
  %72 = getelementptr inbounds [32 x float], ptr %70, i32 0, i32 %71
  store float %67, ptr %72, align 4
  br label %73

73:                                               ; preds = %66
  %74 = load i32, ptr %8, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, ptr %8, align 4
  br label %17, !llvm.loop !14

76:                                               ; preds = %17
  br label %77

77:                                               ; preds = %76
  %78 = load i32, ptr %7, align 4
  %79 = add nsw i32 %78, 1
  store i32 %79, ptr %7, align 4
  br label %13, !llvm.loop !15

80:                                               ; preds = %13
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

17:                                               ; preds = %171, %1
  %18 = load i32, ptr %3, align 4
  %19 = icmp sle i32 %18, 12
  br i1 %19, label %20, label %174

20:                                               ; preds = %17
  %21 = load i32, ptr %3, align 4
  %22 = shl i32 1, %21
  store i32 %22, ptr %4, align 4
  %23 = load i32, ptr %4, align 4
  %24 = ashr i32 %23, 1
  store i32 %24, ptr %5, align 4
  %25 = load i32, ptr %5, align 4
  %26 = sitofp i32 %25 to double
  call void @__divdc3(ptr sret({ double, double }) align 8 %7, double noundef -0.000000e+00, double noundef 0xC00921FB54442D18, double noundef %26, double noundef 0.000000e+00) #5
  %27 = getelementptr inbounds { double, double }, ptr %7, i32 0, i32 0
  %28 = load double, ptr %27, align 8
  %29 = getelementptr inbounds { double, double }, ptr %7, i32 0, i32 1
  %30 = load double, ptr %29, align 8
  %31 = getelementptr inbounds { double, double }, ptr %9, i32 0, i32 0
  %32 = getelementptr inbounds { double, double }, ptr %9, i32 0, i32 1
  store double %28, ptr %31, align 8
  store double %30, ptr %32, align 8
  call void @cexp(ptr sret({ double, double }) align 8 %8, ptr noundef %9) #5
  %33 = getelementptr inbounds { double, double }, ptr %8, i32 0, i32 0
  %34 = load double, ptr %33, align 8
  %35 = getelementptr inbounds { double, double }, ptr %8, i32 0, i32 1
  %36 = load double, ptr %35, align 8
  %37 = fptrunc double %34 to float
  %38 = fptrunc double %36 to float
  %39 = getelementptr inbounds { float, float }, ptr %6, i32 0, i32 0
  %40 = getelementptr inbounds { float, float }, ptr %6, i32 0, i32 1
  store float %37, ptr %39, align 4
  store float %38, ptr %40, align 4
  store i32 0, ptr %10, align 4
  br label %41

41:                                               ; preds = %166, %20
  %42 = load i32, ptr %10, align 4
  %43 = icmp slt i32 %42, 4096
  br i1 %43, label %44, label %170

44:                                               ; preds = %41
  %45 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 0
  %46 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 1
  store float 1.000000e+00, ptr %45, align 4
  store float 0.000000e+00, ptr %46, align 4
  store i32 0, ptr %12, align 4
  br label %47

47:                                               ; preds = %162, %44
  %48 = load i32, ptr %12, align 4
  %49 = load i32, ptr %5, align 4
  %50 = icmp slt i32 %48, %49
  br i1 %50, label %51, label %165

51:                                               ; preds = %47
  %52 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 0
  %53 = load float, ptr %52, align 4
  %54 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 1
  %55 = load float, ptr %54, align 4
  %56 = load ptr, ptr %2, align 4
  %57 = load i32, ptr %10, align 4
  %58 = load i32, ptr %12, align 4
  %59 = add nsw i32 %57, %58
  %60 = load i32, ptr %5, align 4
  %61 = add nsw i32 %59, %60
  %62 = getelementptr inbounds { float, float }, ptr %56, i32 %61
  %63 = getelementptr inbounds { float, float }, ptr %62, i32 0, i32 0
  %64 = load float, ptr %63, align 4
  %65 = getelementptr inbounds { float, float }, ptr %62, i32 0, i32 1
  %66 = load float, ptr %65, align 4
  %67 = fmul float %53, %64
  %68 = fmul float %55, %66
  %69 = fmul float %53, %66
  %70 = fmul float %55, %64
  %71 = fsub float %67, %68
  %72 = fadd float %69, %70
  %73 = fcmp uno float %71, %71
  br i1 %73, label %74, label %82, !prof !16

74:                                               ; preds = %51
  %75 = fcmp uno float %72, %72
  br i1 %75, label %76, label %82, !prof !16

76:                                               ; preds = %74
  %77 = call [2 x i32] @__mulsc3(float noundef %53, float noundef %55, float noundef %64, float noundef %66) #5
  store [2 x i32] %77, ptr %14, align 4
  %78 = getelementptr inbounds { float, float }, ptr %14, i32 0, i32 0
  %79 = load float, ptr %78, align 4
  %80 = getelementptr inbounds { float, float }, ptr %14, i32 0, i32 1
  %81 = load float, ptr %80, align 4
  br label %82

82:                                               ; preds = %76, %74, %51
  %83 = phi float [ %71, %51 ], [ %71, %74 ], [ %79, %76 ]
  %84 = phi float [ %72, %51 ], [ %72, %74 ], [ %81, %76 ]
  %85 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 0
  %86 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 1
  store float %83, ptr %85, align 4
  store float %84, ptr %86, align 4
  %87 = load ptr, ptr %2, align 4
  %88 = load i32, ptr %10, align 4
  %89 = load i32, ptr %12, align 4
  %90 = add nsw i32 %88, %89
  %91 = getelementptr inbounds { float, float }, ptr %87, i32 %90
  %92 = getelementptr inbounds { float, float }, ptr %91, i32 0, i32 0
  %93 = load float, ptr %92, align 4
  %94 = getelementptr inbounds { float, float }, ptr %91, i32 0, i32 1
  %95 = load float, ptr %94, align 4
  %96 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 0
  %97 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 1
  store float %93, ptr %96, align 4
  store float %95, ptr %97, align 4
  %98 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 0
  %99 = load float, ptr %98, align 4
  %100 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 1
  %101 = load float, ptr %100, align 4
  %102 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 0
  %103 = load float, ptr %102, align 4
  %104 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 1
  %105 = load float, ptr %104, align 4
  %106 = fadd float %99, %103
  %107 = fadd float %101, %105
  %108 = load ptr, ptr %2, align 4
  %109 = load i32, ptr %10, align 4
  %110 = load i32, ptr %12, align 4
  %111 = add nsw i32 %109, %110
  %112 = getelementptr inbounds { float, float }, ptr %108, i32 %111
  %113 = getelementptr inbounds { float, float }, ptr %112, i32 0, i32 0
  %114 = getelementptr inbounds { float, float }, ptr %112, i32 0, i32 1
  store float %106, ptr %113, align 4
  store float %107, ptr %114, align 4
  %115 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 0
  %116 = load float, ptr %115, align 4
  %117 = getelementptr inbounds { float, float }, ptr %15, i32 0, i32 1
  %118 = load float, ptr %117, align 4
  %119 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 0
  %120 = load float, ptr %119, align 4
  %121 = getelementptr inbounds { float, float }, ptr %13, i32 0, i32 1
  %122 = load float, ptr %121, align 4
  %123 = fsub float %116, %120
  %124 = fsub float %118, %122
  %125 = load ptr, ptr %2, align 4
  %126 = load i32, ptr %10, align 4
  %127 = load i32, ptr %12, align 4
  %128 = add nsw i32 %126, %127
  %129 = load i32, ptr %5, align 4
  %130 = add nsw i32 %128, %129
  %131 = getelementptr inbounds { float, float }, ptr %125, i32 %130
  %132 = getelementptr inbounds { float, float }, ptr %131, i32 0, i32 0
  %133 = getelementptr inbounds { float, float }, ptr %131, i32 0, i32 1
  store float %123, ptr %132, align 4
  store float %124, ptr %133, align 4
  %134 = getelementptr inbounds { float, float }, ptr %6, i32 0, i32 0
  %135 = load float, ptr %134, align 4
  %136 = getelementptr inbounds { float, float }, ptr %6, i32 0, i32 1
  %137 = load float, ptr %136, align 4
  %138 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 0
  %139 = load float, ptr %138, align 4
  %140 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 1
  %141 = load float, ptr %140, align 4
  %142 = fmul float %139, %135
  %143 = fmul float %141, %137
  %144 = fmul float %139, %137
  %145 = fmul float %141, %135
  %146 = fsub float %142, %143
  %147 = fadd float %144, %145
  %148 = fcmp uno float %146, %146
  br i1 %148, label %149, label %157, !prof !16

149:                                              ; preds = %82
  %150 = fcmp uno float %147, %147
  br i1 %150, label %151, label %157, !prof !16

151:                                              ; preds = %149
  %152 = call [2 x i32] @__mulsc3(float noundef %139, float noundef %141, float noundef %135, float noundef %137) #5
  store [2 x i32] %152, ptr %16, align 4
  %153 = getelementptr inbounds { float, float }, ptr %16, i32 0, i32 0
  %154 = load float, ptr %153, align 4
  %155 = getelementptr inbounds { float, float }, ptr %16, i32 0, i32 1
  %156 = load float, ptr %155, align 4
  br label %157

157:                                              ; preds = %151, %149, %82
  %158 = phi float [ %146, %82 ], [ %146, %149 ], [ %154, %151 ]
  %159 = phi float [ %147, %82 ], [ %147, %149 ], [ %156, %151 ]
  %160 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 0
  %161 = getelementptr inbounds { float, float }, ptr %11, i32 0, i32 1
  store float %158, ptr %160, align 4
  store float %159, ptr %161, align 4
  br label %162

162:                                              ; preds = %157
  %163 = load i32, ptr %12, align 4
  %164 = add nsw i32 %163, 1
  store i32 %164, ptr %12, align 4
  br label %47, !llvm.loop !17

165:                                              ; preds = %47
  br label %166

166:                                              ; preds = %165
  %167 = load i32, ptr %4, align 4
  %168 = load i32, ptr %10, align 4
  %169 = add nsw i32 %168, %167
  store i32 %169, ptr %10, align 4
  br label %41, !llvm.loop !18

170:                                              ; preds = %41
  br label %171

171:                                              ; preds = %170
  %172 = load i32, ptr %3, align 4
  %173 = add nsw i32 %172, 1
  store i32 %173, ptr %3, align 4
  br label %17, !llvm.loop !19

174:                                              ; preds = %17
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
  br i1 %17, label %18, label %53

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
  %33 = call float @tanhf(float noundef %32) #5
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
  %52 = add nsw i32 %51, 1
  store i32 %52, ptr %7, align 4
  br label %14, !llvm.loop !20

53:                                               ; preds = %14
  %54 = load double, ptr %5, align 8
  %55 = load i32, ptr %4, align 4
  %56 = sitofp i32 %55 to double
  %57 = fdiv double %54, %56
  store double %57, ptr %10, align 8
  %58 = load double, ptr %6, align 8
  %59 = load i32, ptr %4, align 4
  %60 = sitofp i32 %59 to double
  %61 = fdiv double %58, %60
  %62 = load double, ptr %10, align 8
  %63 = load double, ptr %10, align 8
  %64 = fneg double %62
  %65 = call double @llvm.fmuladd.f64(double %64, double %63, double %61)
  %66 = fadd double %65, 1.000000e-05
  store double %66, ptr %11, align 8
  %67 = load double, ptr %11, align 8
  %68 = call double @sqrt(double noundef %67) #5
  %69 = fdiv double 1.000000e+00, %68
  store double %69, ptr %12, align 8
  store i32 0, ptr %13, align 4
  br label %70

70:                                               ; preds = %88, %53
  %71 = load i32, ptr %13, align 4
  %72 = load i32, ptr %4, align 4
  %73 = icmp slt i32 %71, %72
  br i1 %73, label %74, label %91

74:                                               ; preds = %70
  %75 = load ptr, ptr %3, align 4
  %76 = load i32, ptr %13, align 4
  %77 = getelementptr inbounds float, ptr %75, i32 %76
  %78 = load float, ptr %77, align 4
  %79 = fpext float %78 to double
  %80 = load double, ptr %10, align 8
  %81 = fsub double %79, %80
  %82 = load double, ptr %12, align 8
  %83 = fmul double %81, %82
  %84 = fptrunc double %83 to float
  %85 = load ptr, ptr %3, align 4
  %86 = load i32, ptr %13, align 4
  %87 = getelementptr inbounds float, ptr %85, i32 %86
  store float %84, ptr %87, align 4
  br label %88

88:                                               ; preds = %74
  %89 = load i32, ptr %13, align 4
  %90 = add nsw i32 %89, 1
  store i32 %90, ptr %13, align 4
  br label %70, !llvm.loop !21

91:                                               ; preds = %70
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

10:                                               ; preds = %42, %2
  %11 = load i32, ptr %5, align 4
  %12 = load i32, ptr %4, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %45

14:                                               ; preds = %10
  store i32 0, ptr %6, align 4
  br label %15

15:                                               ; preds = %36, %14
  %16 = load i32, ptr %6, align 4
  %17 = load i32, ptr %4, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %41

19:                                               ; preds = %15
  %20 = load ptr, ptr %3, align 4
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %5, align 4
  %23 = add nsw i32 %21, %22
  %24 = sub nsw i32 %23, 1
  %25 = getelementptr inbounds i32, ptr %20, i32 %24
  %26 = load i32, ptr %25, align 4
  %27 = load ptr, ptr %3, align 4
  %28 = load i32, ptr %6, align 4
  %29 = load i32, ptr %5, align 4
  %30 = mul nsw i32 2, %29
  %31 = add nsw i32 %28, %30
  %32 = sub nsw i32 %31, 1
  %33 = getelementptr inbounds i32, ptr %27, i32 %32
  %34 = load i32, ptr %33, align 4
  %35 = add nsw i32 %34, %26
  store i32 %35, ptr %33, align 4
  br label %36

36:                                               ; preds = %19
  %37 = load i32, ptr %5, align 4
  %38 = mul nsw i32 2, %37
  %39 = load i32, ptr %6, align 4
  %40 = add nsw i32 %39, %38
  store i32 %40, ptr %6, align 4
  br label %15, !llvm.loop !22

41:                                               ; preds = %15
  br label %42

42:                                               ; preds = %41
  %43 = load i32, ptr %5, align 4
  %44 = shl i32 %43, 1
  store i32 %44, ptr %5, align 4
  br label %10, !llvm.loop !23

45:                                               ; preds = %10
  %46 = load ptr, ptr %3, align 4
  %47 = load i32, ptr %4, align 4
  %48 = sub nsw i32 %47, 1
  %49 = getelementptr inbounds i32, ptr %46, i32 %48
  store i32 0, ptr %49, align 4
  %50 = load i32, ptr %4, align 4
  %51 = ashr i32 %50, 1
  store i32 %51, ptr %7, align 4
  br label %52

52:                                               ; preds = %98, %45
  %53 = load i32, ptr %7, align 4
  %54 = icmp sge i32 %53, 1
  br i1 %54, label %55, label %101

55:                                               ; preds = %52
  store i32 0, ptr %8, align 4
  br label %56

56:                                               ; preds = %92, %55
  %57 = load i32, ptr %8, align 4
  %58 = load i32, ptr %4, align 4
  %59 = icmp slt i32 %57, %58
  br i1 %59, label %60, label %97

60:                                               ; preds = %56
  %61 = load ptr, ptr %3, align 4
  %62 = load i32, ptr %8, align 4
  %63 = load i32, ptr %7, align 4
  %64 = add nsw i32 %62, %63
  %65 = sub nsw i32 %64, 1
  %66 = getelementptr inbounds i32, ptr %61, i32 %65
  %67 = load i32, ptr %66, align 4
  store i32 %67, ptr %9, align 4
  %68 = load ptr, ptr %3, align 4
  %69 = load i32, ptr %8, align 4
  %70 = load i32, ptr %7, align 4
  %71 = mul nsw i32 2, %70
  %72 = add nsw i32 %69, %71
  %73 = sub nsw i32 %72, 1
  %74 = getelementptr inbounds i32, ptr %68, i32 %73
  %75 = load i32, ptr %74, align 4
  %76 = load ptr, ptr %3, align 4
  %77 = load i32, ptr %8, align 4
  %78 = load i32, ptr %7, align 4
  %79 = add nsw i32 %77, %78
  %80 = sub nsw i32 %79, 1
  %81 = getelementptr inbounds i32, ptr %76, i32 %80
  store i32 %75, ptr %81, align 4
  %82 = load i32, ptr %9, align 4
  %83 = load ptr, ptr %3, align 4
  %84 = load i32, ptr %8, align 4
  %85 = load i32, ptr %7, align 4
  %86 = mul nsw i32 2, %85
  %87 = add nsw i32 %84, %86
  %88 = sub nsw i32 %87, 1
  %89 = getelementptr inbounds i32, ptr %83, i32 %88
  %90 = load i32, ptr %89, align 4
  %91 = add nsw i32 %90, %82
  store i32 %91, ptr %89, align 4
  br label %92

92:                                               ; preds = %60
  %93 = load i32, ptr %7, align 4
  %94 = mul nsw i32 2, %93
  %95 = load i32, ptr %8, align 4
  %96 = add nsw i32 %95, %94
  store i32 %96, ptr %8, align 4
  br label %56, !llvm.loop !24

97:                                               ; preds = %56
  br label %98

98:                                               ; preds = %97
  %99 = load i32, ptr %7, align 4
  %100 = ashr i32 %99, 1
  store i32 %100, ptr %7, align 4
  br label %52, !llvm.loop !25

101:                                              ; preds = %52
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

13:                                               ; preds = %61, %0
  %14 = load i32, ptr %2, align 4
  %15 = icmp slt i32 %14, 64
  br i1 %15, label %16, label %64

16:                                               ; preds = %13
  store i32 0, ptr %3, align 4
  br label %17

17:                                               ; preds = %57, %16
  %18 = load i32, ptr %3, align 4
  %19 = icmp slt i32 %18, 64
  br i1 %19, label %20, label %60

20:                                               ; preds = %17
  store i32 0, ptr %4, align 4
  br label %21

21:                                               ; preds = %53, %20
  %22 = load i32, ptr %4, align 4
  %23 = icmp slt i32 %22, 64
  br i1 %23, label %24, label %56

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
  %34 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.A, i32 0, i32 %33
  %35 = load i32, ptr %3, align 4
  %36 = getelementptr inbounds [64 x [64 x float]], ptr %34, i32 0, i32 %35
  %37 = load i32, ptr %4, align 4
  %38 = getelementptr inbounds [64 x float], ptr %36, i32 0, i32 %37
  store float %32, ptr %38, align 4
  %39 = load i32, ptr %2, align 4
  %40 = load i32, ptr %3, align 4
  %41 = sub nsw i32 %39, %40
  %42 = load i32, ptr %4, align 4
  %43 = add nsw i32 %41, %42
  %44 = and i32 %43, 3
  %45 = sitofp i32 %44 to float
  %46 = fmul float %45, 0x3F947AE140000000
  %47 = load i32, ptr %2, align 4
  %48 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.B, i32 0, i32 %47
  %49 = load i32, ptr %3, align 4
  %50 = getelementptr inbounds [64 x [64 x float]], ptr %48, i32 0, i32 %49
  %51 = load i32, ptr %4, align 4
  %52 = getelementptr inbounds [64 x float], ptr %50, i32 0, i32 %51
  store float %46, ptr %52, align 4
  br label %53

53:                                               ; preds = %24
  %54 = load i32, ptr %4, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %4, align 4
  br label %21, !llvm.loop !26

56:                                               ; preds = %21
  br label %57

57:                                               ; preds = %56
  %58 = load i32, ptr %3, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %3, align 4
  br label %17, !llvm.loop !27

60:                                               ; preds = %17
  br label %61

61:                                               ; preds = %60
  %62 = load i32, ptr %2, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %2, align 4
  br label %13, !llvm.loop !28

64:                                               ; preds = %13
  call void @batched_gemm(ptr noundef @main.A, ptr noundef @main.B, ptr noundef @main.C)
  %65 = load float, ptr @main.C, align 4
  %66 = fpext float %65 to double
  %67 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %66)
  store i32 0, ptr %5, align 4
  br label %68

68:                                               ; preds = %101, %64
  %69 = load i32, ptr %5, align 4
  %70 = icmp slt i32 %69, 16
  br i1 %70, label %71, label %104

71:                                               ; preds = %68
  store i32 0, ptr %6, align 4
  br label %72

72:                                               ; preds = %97, %71
  %73 = load i32, ptr %6, align 4
  %74 = icmp slt i32 %73, 5
  br i1 %74, label %75, label %100

75:                                               ; preds = %72
  store i32 0, ptr %7, align 4
  br label %76

76:                                               ; preds = %93, %75
  %77 = load i32, ptr %7, align 4
  %78 = icmp slt i32 %77, 5
  br i1 %78, label %79, label %96

79:                                               ; preds = %76
  %80 = load i32, ptr %5, align 4
  %81 = load i32, ptr %6, align 4
  %82 = add nsw i32 %80, %81
  %83 = load i32, ptr %7, align 4
  %84 = add nsw i32 %82, %83
  %85 = sitofp i32 %84 to float
  %86 = fmul float %85, 0x3F847AE140000000
  %87 = load i32, ptr %5, align 4
  %88 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %87
  %89 = load i32, ptr %6, align 4
  %90 = getelementptr inbounds [5 x [5 x float]], ptr %88, i32 0, i32 %89
  %91 = load i32, ptr %7, align 4
  %92 = getelementptr inbounds [5 x float], ptr %90, i32 0, i32 %91
  store float %86, ptr %92, align 4
  br label %93

93:                                               ; preds = %79
  %94 = load i32, ptr %7, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, ptr %7, align 4
  br label %76, !llvm.loop !29

96:                                               ; preds = %76
  br label %97

97:                                               ; preds = %96
  %98 = load i32, ptr %6, align 4
  %99 = add nsw i32 %98, 1
  store i32 %99, ptr %6, align 4
  br label %72, !llvm.loop !30

100:                                              ; preds = %72
  br label %101

101:                                              ; preds = %100
  %102 = load i32, ptr %5, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, ptr %5, align 4
  br label %68, !llvm.loop !31

104:                                              ; preds = %68
  call void @conv2d(ptr noundef @main.IN, ptr noundef @main.Wt, ptr noundef @main.O)
  %105 = load float, ptr @main.O, align 4
  %106 = fpext float %105 to double
  %107 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %106)
  store i32 0, ptr %8, align 4
  br label %108

108:                                              ; preds = %122, %104
  %109 = load i32, ptr %8, align 4
  %110 = icmp slt i32 %109, 4096
  br i1 %110, label %111, label %125

111:                                              ; preds = %108
  %112 = load i32, ptr %8, align 4
  %113 = sitofp i32 %112 to double
  %114 = fmul double 0x4073A28C59D5433B, %113
  %115 = fdiv double %114, 4.096000e+03
  %116 = call double @sin(double noundef %115) #5
  %117 = fptrunc double %116 to float
  %118 = load i32, ptr %8, align 4
  %119 = getelementptr inbounds [4096 x { float, float }], ptr @main.sig, i32 0, i32 %118
  %120 = getelementptr inbounds { float, float }, ptr %119, i32 0, i32 0
  %121 = getelementptr inbounds { float, float }, ptr %119, i32 0, i32 1
  store float %117, ptr %120, align 4
  store float 0.000000e+00, ptr %121, align 4
  br label %122

122:                                              ; preds = %111
  %123 = load i32, ptr %8, align 4
  %124 = add nsw i32 %123, 1
  store i32 %124, ptr %8, align 4
  br label %108, !llvm.loop !32

125:                                              ; preds = %108
  call void @fft_4096(ptr noundef @main.sig)
  %126 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1), align 4
  %127 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1, i32 1), align 4
  %128 = fpext float %126 to double
  %129 = fpext float %127 to double
  %130 = fptrunc double %128 to float
  %131 = fpext float %130 to double
  %132 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1), align 4
  %133 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1, i32 1), align 4
  %134 = fpext float %132 to double
  %135 = fpext float %133 to double
  %136 = fptrunc double %135 to float
  %137 = fpext float %136 to double
  %138 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %131, double noundef %137)
  %139 = call noalias ptr @malloc(i32 noundef 16384) #6
  store ptr %139, ptr %9, align 4
  store i32 0, ptr %10, align 4
  br label %140

140:                                              ; preds = %151, %125
  %141 = load i32, ptr %10, align 4
  %142 = icmp slt i32 %141, 4096
  br i1 %142, label %143, label %154

143:                                              ; preds = %140
  %144 = load i32, ptr %10, align 4
  %145 = sitofp i32 %144 to float
  %146 = fdiv float %145, 2.048000e+03
  %147 = fsub float %146, 1.000000e+00
  %148 = load ptr, ptr %9, align 4
  %149 = load i32, ptr %10, align 4
  %150 = getelementptr inbounds float, ptr %148, i32 %149
  store float %147, ptr %150, align 4
  br label %151

151:                                              ; preds = %143
  %152 = load i32, ptr %10, align 4
  %153 = add nsw i32 %152, 1
  store i32 %153, ptr %10, align 4
  br label %140, !llvm.loop !33

154:                                              ; preds = %140
  %155 = load ptr, ptr %9, align 4
  call void @gelu_layernorm(ptr noundef %155, i32 noundef 4096)
  %156 = load ptr, ptr %9, align 4
  %157 = getelementptr inbounds float, ptr %156, i32 0
  %158 = load float, ptr %157, align 4
  %159 = fpext float %158 to double
  %160 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, double noundef %159)
  %161 = call noalias ptr @malloc(i32 noundef 16384) #6
  store ptr %161, ptr %11, align 4
  store i32 0, ptr %12, align 4
  br label %162

162:                                              ; preds = %169, %154
  %163 = load i32, ptr %12, align 4
  %164 = icmp slt i32 %163, 4096
  br i1 %164, label %165, label %172

165:                                              ; preds = %162
  %166 = load ptr, ptr %11, align 4
  %167 = load i32, ptr %12, align 4
  %168 = getelementptr inbounds i32, ptr %166, i32 %167
  store i32 1, ptr %168, align 4
  br label %169

169:                                              ; preds = %165
  %170 = load i32, ptr %12, align 4
  %171 = add nsw i32 %170, 1
  store i32 %171, ptr %12, align 4
  br label %162, !llvm.loop !34

172:                                              ; preds = %162
  %173 = load ptr, ptr %11, align 4
  call void @prefix_sum(ptr noundef %173, i32 noundef 4096)
  %174 = load ptr, ptr %11, align 4
  %175 = getelementptr inbounds i32, ptr %174, i32 4095
  %176 = load i32, ptr %175, align 4
  %177 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef 4095, i32 noundef %176)
  %178 = load ptr, ptr %9, align 4
  call void @free(ptr noundef %178)
  %179 = load ptr, ptr %11, align 4
  call void @free(ptr noundef %179)
  ret i32 0
}

declare dso_local i32 @printf(ptr noundef, ...) #3

; Function Attrs: nounwind
declare dso_local double @sin(double noundef) #2

; Function Attrs: allocsize(0)
declare dso_local noalias ptr @malloc(i32 noundef) #4

declare dso_local void @free(ptr noundef) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { nounwind }
attributes #6 = { allocsize(0) }

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
