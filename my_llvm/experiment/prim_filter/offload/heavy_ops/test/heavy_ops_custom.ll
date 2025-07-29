; ModuleID = 'heavy_ops.ll'
source_filename = "heavy_ops.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-unknown-elf"

@main.A = internal unnamed_addr global [64 x [64 x [64 x float]]] zeroinitializer, align 4
@main.B = internal unnamed_addr global [64 x [64 x [64 x float]]] zeroinitializer, align 4
@main.C = internal unnamed_addr global [64 x [64 x [64 x float]]] zeroinitializer, align 4
@.str = private unnamed_addr constant [15 x i8] c"C[0][0][0]=%f\0A\00", align 1
@main.IN = internal global [16 x [36 x [36 x float]]] zeroinitializer, align 4
@main.Wt = internal global [16 x [5 x [5 x float]]] zeroinitializer, align 4
@main.O = internal global [32 x [32 x float]] zeroinitializer, align 4
@.str.1 = private unnamed_addr constant [12 x i8] c"O[0][0]=%f\0A\00", align 1
@main.sig = internal global [4096 x { float, float }] zeroinitializer, align 4
@.str.2 = private unnamed_addr constant [15 x i8] c"FFT[1]=%f%+fi\0A\00", align 1
@.str.3 = private unnamed_addr constant [11 x i8] c"vec[0]=%f\0A\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"scan[%d]=%d\0A\00", align 1

; Function Attrs: nofree nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @batched_gemm(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2) local_unnamed_addr #0 {
  br label %4

4:                                                ; preds = %9, %3
  %5 = phi i32 [ 0, %3 ], [ %custom3, %9 ]
  br label %7

6:                                                ; preds = %9
  ret void

7:                                                ; preds = %13, %4
  %8 = phi i32 [ 0, %4 ], [ %custom31, %13 ]
  br label %11

9:                                                ; preds = %13
  %custom3 = call i32 @llvm.riscv.custom3(i32 %5, i32 1)
  %10 = icmp eq i32 %custom3, 64
  br i1 %10, label %6, label %4, !llvm.loop !5

11:                                               ; preds = %15, %7
  %12 = phi i32 [ 0, %7 ], [ %custom32, %15 ]
  br label %18

13:                                               ; preds = %15
  %custom31 = call i32 @llvm.riscv.custom3(i32 %8, i32 1)
  %14 = icmp eq i32 %custom31, 64
  br i1 %14, label %9, label %7, !llvm.loop !7

15:                                               ; preds = %18
  %16 = getelementptr inbounds [64 x [64 x float]], ptr %2, i32 %5, i32 %8, i32 %12
  store float %25, ptr %16, align 4, !tbaa !8
  %custom32 = call i32 @llvm.riscv.custom3(i32 %12, i32 1)
  %17 = icmp eq i32 %custom32, 64
  br i1 %17, label %13, label %11, !llvm.loop !12

18:                                               ; preds = %18, %11
  %19 = phi i32 [ 0, %11 ], [ %custom33, %18 ]
  %20 = phi float [ 0.000000e+00, %11 ], [ %25, %18 ]
  %21 = getelementptr inbounds [64 x [64 x float]], ptr %0, i32 %5, i32 %8, i32 %19
  %22 = load float, ptr %21, align 4, !tbaa !8
  %23 = getelementptr inbounds [64 x [64 x float]], ptr %1, i32 %5, i32 %19, i32 %12
  %24 = load float, ptr %23, align 4, !tbaa !8
  %25 = tail call float @llvm.fmuladd.f32(float %22, float %24, float %20)
  %custom33 = call i32 @llvm.riscv.custom3(i32 %19, i32 1)
  %26 = icmp eq i32 %custom33, 64
  br i1 %26, label %15, label %18, !llvm.loop !13
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nofree nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @conv2d(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2) local_unnamed_addr #0 {
  br label %4

4:                                                ; preds = %9, %3
  %5 = phi i32 [ 0, %3 ], [ %custom3, %9 ]
  %custom3 = call i32 @llvm.riscv.custom3(i32 %5, i32 1)
  %custom31 = call i32 @llvm.riscv.custom3(i32 %5, i32 2)
  %custom32 = call i32 @llvm.riscv.custom3(i32 %5, i32 3)
  %custom33 = call i32 @llvm.riscv.custom3(i32 %5, i32 4)
  br label %7

6:                                                ; preds = %9
  ret void

7:                                                ; preds = %140, %4
  %8 = phi i32 [ 0, %4 ], [ %custom34, %140 ]
  %custom34 = call i32 @llvm.riscv.custom3(i32 %8, i32 1)
  %custom35 = call i32 @llvm.riscv.custom3(i32 %8, i32 2)
  %custom36 = call i32 @llvm.riscv.custom3(i32 %8, i32 3)
  %custom37 = call i32 @llvm.riscv.custom3(i32 %8, i32 4)
  br label %11

9:                                                ; preds = %140
  %10 = icmp eq i32 %custom3, 32
  br i1 %10, label %6, label %4, !llvm.loop !14

11:                                               ; preds = %11, %7
  %12 = phi i32 [ 0, %7 ], [ %custom38, %11 ]
  %13 = phi float [ 0.000000e+00, %7 ], [ %138, %11 ]
  %14 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %5, i32 %8
  %15 = load float, ptr %14, align 4, !tbaa !8
  %16 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 0, i32 0
  %17 = load float, ptr %16, align 4, !tbaa !8
  %18 = tail call float @llvm.fmuladd.f32(float %15, float %17, float %13)
  %19 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %5, i32 %custom34
  %20 = load float, ptr %19, align 4, !tbaa !8
  %21 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 0, i32 1
  %22 = load float, ptr %21, align 4, !tbaa !8
  %23 = tail call float @llvm.fmuladd.f32(float %20, float %22, float %18)
  %24 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %5, i32 %custom35
  %25 = load float, ptr %24, align 4, !tbaa !8
  %26 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 0, i32 2
  %27 = load float, ptr %26, align 4, !tbaa !8
  %28 = tail call float @llvm.fmuladd.f32(float %25, float %27, float %23)
  %29 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %5, i32 %custom36
  %30 = load float, ptr %29, align 4, !tbaa !8
  %31 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 0, i32 3
  %32 = load float, ptr %31, align 4, !tbaa !8
  %33 = tail call float @llvm.fmuladd.f32(float %30, float %32, float %28)
  %34 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %5, i32 %custom37
  %35 = load float, ptr %34, align 4, !tbaa !8
  %36 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 0, i32 4
  %37 = load float, ptr %36, align 4, !tbaa !8
  %38 = tail call float @llvm.fmuladd.f32(float %35, float %37, float %33)
  %39 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom3, i32 %8
  %40 = load float, ptr %39, align 4, !tbaa !8
  %41 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 1, i32 0
  %42 = load float, ptr %41, align 4, !tbaa !8
  %43 = tail call float @llvm.fmuladd.f32(float %40, float %42, float %38)
  %44 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom3, i32 %custom34
  %45 = load float, ptr %44, align 4, !tbaa !8
  %46 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 1, i32 1
  %47 = load float, ptr %46, align 4, !tbaa !8
  %48 = tail call float @llvm.fmuladd.f32(float %45, float %47, float %43)
  %49 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom3, i32 %custom35
  %50 = load float, ptr %49, align 4, !tbaa !8
  %51 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 1, i32 2
  %52 = load float, ptr %51, align 4, !tbaa !8
  %53 = tail call float @llvm.fmuladd.f32(float %50, float %52, float %48)
  %54 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom3, i32 %custom36
  %55 = load float, ptr %54, align 4, !tbaa !8
  %56 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 1, i32 3
  %57 = load float, ptr %56, align 4, !tbaa !8
  %58 = tail call float @llvm.fmuladd.f32(float %55, float %57, float %53)
  %59 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom3, i32 %custom37
  %60 = load float, ptr %59, align 4, !tbaa !8
  %61 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 1, i32 4
  %62 = load float, ptr %61, align 4, !tbaa !8
  %63 = tail call float @llvm.fmuladd.f32(float %60, float %62, float %58)
  %64 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom31, i32 %8
  %65 = load float, ptr %64, align 4, !tbaa !8
  %66 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 2, i32 0
  %67 = load float, ptr %66, align 4, !tbaa !8
  %68 = tail call float @llvm.fmuladd.f32(float %65, float %67, float %63)
  %69 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom31, i32 %custom34
  %70 = load float, ptr %69, align 4, !tbaa !8
  %71 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 2, i32 1
  %72 = load float, ptr %71, align 4, !tbaa !8
  %73 = tail call float @llvm.fmuladd.f32(float %70, float %72, float %68)
  %74 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom31, i32 %custom35
  %75 = load float, ptr %74, align 4, !tbaa !8
  %76 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 2, i32 2
  %77 = load float, ptr %76, align 4, !tbaa !8
  %78 = tail call float @llvm.fmuladd.f32(float %75, float %77, float %73)
  %79 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom31, i32 %custom36
  %80 = load float, ptr %79, align 4, !tbaa !8
  %81 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 2, i32 3
  %82 = load float, ptr %81, align 4, !tbaa !8
  %83 = tail call float @llvm.fmuladd.f32(float %80, float %82, float %78)
  %84 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom31, i32 %custom37
  %85 = load float, ptr %84, align 4, !tbaa !8
  %86 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 2, i32 4
  %87 = load float, ptr %86, align 4, !tbaa !8
  %88 = tail call float @llvm.fmuladd.f32(float %85, float %87, float %83)
  %89 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom32, i32 %8
  %90 = load float, ptr %89, align 4, !tbaa !8
  %91 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 3, i32 0
  %92 = load float, ptr %91, align 4, !tbaa !8
  %93 = tail call float @llvm.fmuladd.f32(float %90, float %92, float %88)
  %94 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom32, i32 %custom34
  %95 = load float, ptr %94, align 4, !tbaa !8
  %96 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 3, i32 1
  %97 = load float, ptr %96, align 4, !tbaa !8
  %98 = tail call float @llvm.fmuladd.f32(float %95, float %97, float %93)
  %99 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom32, i32 %custom35
  %100 = load float, ptr %99, align 4, !tbaa !8
  %101 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 3, i32 2
  %102 = load float, ptr %101, align 4, !tbaa !8
  %103 = tail call float @llvm.fmuladd.f32(float %100, float %102, float %98)
  %104 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom32, i32 %custom36
  %105 = load float, ptr %104, align 4, !tbaa !8
  %106 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 3, i32 3
  %107 = load float, ptr %106, align 4, !tbaa !8
  %108 = tail call float @llvm.fmuladd.f32(float %105, float %107, float %103)
  %109 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom32, i32 %custom37
  %110 = load float, ptr %109, align 4, !tbaa !8
  %111 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 3, i32 4
  %112 = load float, ptr %111, align 4, !tbaa !8
  %113 = tail call float @llvm.fmuladd.f32(float %110, float %112, float %108)
  %114 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom33, i32 %8
  %115 = load float, ptr %114, align 4, !tbaa !8
  %116 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 4, i32 0
  %117 = load float, ptr %116, align 4, !tbaa !8
  %118 = tail call float @llvm.fmuladd.f32(float %115, float %117, float %113)
  %119 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom33, i32 %custom34
  %120 = load float, ptr %119, align 4, !tbaa !8
  %121 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 4, i32 1
  %122 = load float, ptr %121, align 4, !tbaa !8
  %123 = tail call float @llvm.fmuladd.f32(float %120, float %122, float %118)
  %124 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom33, i32 %custom35
  %125 = load float, ptr %124, align 4, !tbaa !8
  %126 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 4, i32 2
  %127 = load float, ptr %126, align 4, !tbaa !8
  %128 = tail call float @llvm.fmuladd.f32(float %125, float %127, float %123)
  %129 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom33, i32 %custom36
  %130 = load float, ptr %129, align 4, !tbaa !8
  %131 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 4, i32 3
  %132 = load float, ptr %131, align 4, !tbaa !8
  %133 = tail call float @llvm.fmuladd.f32(float %130, float %132, float %128)
  %134 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %12, i32 %custom33, i32 %custom37
  %135 = load float, ptr %134, align 4, !tbaa !8
  %136 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %12, i32 4, i32 4
  %137 = load float, ptr %136, align 4, !tbaa !8
  %138 = tail call float @llvm.fmuladd.f32(float %135, float %137, float %133)
  %custom38 = call i32 @llvm.riscv.custom3(i32 %12, i32 1)
  %139 = icmp eq i32 %custom38, 16
  br i1 %139, label %140, label %11, !llvm.loop !15

140:                                              ; preds = %11
  %141 = getelementptr inbounds [32 x float], ptr %2, i32 %5, i32 %8
  store float %138, ptr %141, align 4, !tbaa !8
  %142 = icmp eq i32 %custom34, 32
  br i1 %142, label %9, label %7, !llvm.loop !16
}

; Function Attrs: nounwind uwtable
define dso_local void @fft_4096(ptr noundef captures(none) %0) local_unnamed_addr #2 {
  %2 = alloca { double, double }, align 8
  %3 = alloca { double, double }, align 8
  %4 = alloca { double, double }, align 8
  %5 = getelementptr inbounds { double, double }, ptr %2, i32 0, i32 1
  %6 = getelementptr inbounds { double, double }, ptr %4, i32 0, i32 1
  %7 = getelementptr inbounds { double, double }, ptr %3, i32 0, i32 1
  br label %9

8:                                                ; preds = %21
  ret void

9:                                                ; preds = %21, %1
  %10 = phi i32 [ 1, %1 ], [ %custom32, %21 ]
  %custom3 = call i32 @llvm.riscv.custom3(i32 1, i32 %10)
  %custom31 = call i32 @llvm.riscv.custom3(i32 %custom3, i32 1)
  %11 = sitofp i32 %custom31 to double
  call void @__divdc3(ptr nonnull sret({ double, double }) align 8 %2, double noundef -0.000000e+00, double noundef 0xC00921FB54442D18, double noundef %11, double noundef 0.000000e+00) #11
  %12 = load double, ptr %2, align 8
  %13 = load double, ptr %5, align 8
  store double %12, ptr %4, align 8
  store double %13, ptr %6, align 8
  call void @cexp(ptr nonnull sret({ double, double }) align 8 %3, ptr noundef nonnull %4) #11
  %14 = load double, ptr %3, align 8
  %15 = load double, ptr %7, align 8
  %16 = fptrunc double %14 to float
  %17 = fptrunc double %15 to float
  %18 = call i32 @llvm.umax.i32(i32 %custom31, i32 1)
  br label %19

19:                                               ; preds = %23, %9
  %20 = phi i32 [ 0, %9 ], [ %custom33, %23 ]
  br label %25

21:                                               ; preds = %23
  %custom32 = call i32 @llvm.riscv.custom3(i32 %10, i32 1)
  %22 = icmp eq i32 %custom32, 13
  br i1 %22, label %8, label %9, !llvm.loop !17

23:                                               ; preds = %74
  %custom33 = call i32 @llvm.riscv.custom3(i32 %20, i32 %custom3)
  %24 = icmp ult i32 %custom33, 4096
  br i1 %24, label %19, label %21, !llvm.loop !18

25:                                               ; preds = %74, %19
  %26 = phi float [ %76, %74 ], [ 0.000000e+00, %19 ]
  %27 = phi float [ %75, %74 ], [ 1.000000e+00, %19 ]
  %28 = phi i32 [ %custom36, %74 ], [ 0, %19 ]
  %custom34 = call i32 @llvm.riscv.custom3(i32 %28, i32 %20)
  %custom35 = call i32 @llvm.riscv.custom3(i32 %custom34, i32 %custom31)
  %29 = getelementptr inbounds { float, float }, ptr %0, i32 %custom35
  %30 = load float, ptr %29, align 4
  %31 = getelementptr inbounds { float, float }, ptr %0, i32 %custom35, i32 1
  %32 = load float, ptr %31, align 4
  %33 = fmul float %27, %30
  %34 = fmul float %26, %32
  %35 = fmul float %27, %32
  %36 = fmul float %26, %30
  %37 = fsub float %33, %34
  %38 = fadd float %36, %35
  %39 = fcmp uno float %37, 0.000000e+00
  br i1 %39, label %40, label %48, !prof !19

40:                                               ; preds = %25
  %41 = fcmp uno float %38, 0.000000e+00
  br i1 %41, label %42, label %48, !prof !19

42:                                               ; preds = %40
  %43 = call [2 x i32] @__mulsc3(float noundef %27, float noundef %26, float noundef %30, float noundef %32) #11
  %44 = extractvalue [2 x i32] %43, 0
  %45 = bitcast i32 %44 to float
  %46 = extractvalue [2 x i32] %43, 1
  %47 = bitcast i32 %46 to float
  br label %48

48:                                               ; preds = %42, %40, %25
  %49 = phi float [ %37, %25 ], [ %37, %40 ], [ %45, %42 ]
  %50 = phi float [ %38, %25 ], [ %38, %40 ], [ %47, %42 ]
  %51 = getelementptr inbounds { float, float }, ptr %0, i32 %custom34
  %52 = load float, ptr %51, align 4
  %53 = getelementptr inbounds { float, float }, ptr %0, i32 %custom34, i32 1
  %54 = load float, ptr %53, align 4
  %55 = fadd float %49, %52
  %56 = fadd float %50, %54
  store float %55, ptr %51, align 4
  store float %56, ptr %53, align 4
  %57 = fsub float %52, %49
  %58 = fsub float %54, %50
  store float %57, ptr %29, align 4
  store float %58, ptr %31, align 4
  %59 = fmul float %27, %16
  %60 = fmul float %26, %17
  %61 = fmul float %27, %17
  %62 = fmul float %26, %16
  %63 = fsub float %59, %60
  %64 = fadd float %61, %62
  %65 = fcmp uno float %63, 0.000000e+00
  br i1 %65, label %66, label %74, !prof !19

66:                                               ; preds = %48
  %67 = fcmp uno float %64, 0.000000e+00
  br i1 %67, label %68, label %74, !prof !19

68:                                               ; preds = %66
  %69 = call [2 x i32] @__mulsc3(float noundef %27, float noundef %26, float noundef %16, float noundef %17) #11
  %70 = extractvalue [2 x i32] %69, 0
  %71 = bitcast i32 %70 to float
  %72 = extractvalue [2 x i32] %69, 1
  %73 = bitcast i32 %72 to float
  br label %74

74:                                               ; preds = %68, %66, %48
  %75 = phi float [ %63, %48 ], [ %63, %66 ], [ %71, %68 ]
  %76 = phi float [ %64, %48 ], [ %64, %66 ], [ %73, %68 ]
  %custom36 = call i32 @llvm.riscv.custom3(i32 %28, i32 1)
  %77 = icmp eq i32 %custom36, %18
  br i1 %77, label %23, label %25, !llvm.loop !20
}

; Function Attrs: nounwind
declare dso_local void @cexp(ptr sret({ double, double }) align 8, ptr noundef) local_unnamed_addr #3

declare dso_local void @__divdc3(ptr, double, double, double, double) local_unnamed_addr

declare dso_local [2 x i32] @__mulsc3(float, float, float, float) local_unnamed_addr

; Function Attrs: nofree nounwind memory(write, argmem: readwrite) uwtable
define dso_local void @gelu_layernorm(ptr noundef captures(none) %0, i32 noundef %1) local_unnamed_addr #4 {
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %15, label %4

4:                                                ; preds = %15, %2
  %5 = phi double [ 0.000000e+00, %2 ], [ %33, %15 ]
  %6 = phi double [ 0.000000e+00, %2 ], [ %30, %15 ]
  %7 = sitofp i32 %1 to double
  %8 = fdiv double %6, %7
  %9 = fdiv double %5, %7
  %10 = fneg double %8
  %11 = tail call double @llvm.fmuladd.f64(double %10, double %8, double %9)
  %12 = fadd double %11, 1.000000e-05
  %13 = tail call double @sqrt(double noundef %12) #11
  %14 = fdiv double 1.000000e+00, %13
  br i1 %3, label %36, label %35

15:                                               ; preds = %15, %2
  %16 = phi double [ %30, %15 ], [ 0.000000e+00, %2 ]
  %17 = phi double [ %33, %15 ], [ 0.000000e+00, %2 ]
  %18 = phi i32 [ %custom3, %15 ], [ 0, %2 ]
  %19 = getelementptr inbounds float, ptr %0, i32 %18
  %20 = load float, ptr %19, align 4, !tbaa !8
  %21 = fmul float %20, 5.000000e-01
  %22 = fmul float %20, 0x3FA6E4E260000000
  %23 = fmul float %20, %22
  %24 = tail call float @llvm.fmuladd.f32(float %23, float %20, float %20)
  %25 = fmul float %24, 0x3FE9884540000000
  %26 = tail call float @tanhf(float noundef %25) #11
  %27 = fadd float %26, 1.000000e+00
  %28 = fmul float %21, %27
  store float %28, ptr %19, align 4, !tbaa !8
  %29 = fpext float %28 to double
  %30 = fadd double %16, %29
  %31 = fmul float %28, %28
  %32 = fpext float %31 to double
  %33 = fadd double %17, %32
  %custom3 = call i32 @llvm.riscv.custom3(i32 %18, i32 1)
  %34 = icmp eq i32 %custom3, %1
  br i1 %34, label %4, label %15, !llvm.loop !21

35:                                               ; preds = %36, %4
  ret void

36:                                               ; preds = %36, %4
  %37 = phi i32 [ %custom31, %36 ], [ 0, %4 ]
  %38 = getelementptr inbounds float, ptr %0, i32 %37
  %39 = load float, ptr %38, align 4, !tbaa !8
  %40 = fpext float %39 to double
  %41 = fsub double %40, %8
  %42 = fmul double %14, %41
  %43 = fptrunc double %42 to float
  store float %43, ptr %38, align 4, !tbaa !8
  %custom31 = call i32 @llvm.riscv.custom3(i32 %37, i32 1)
  %44 = icmp eq i32 %custom31, %1
  br i1 %44, label %35, label %36, !llvm.loop !22
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare dso_local float @tanhf(float noundef) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare dso_local double @sqrt(double noundef) local_unnamed_addr #5

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @prefix_sum(ptr noundef captures(none) %0, i32 noundef %1) local_unnamed_addr #6 {
  %3 = icmp sgt i32 %1, 1
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %custom3 = call i32 @llvm.riscv.custom3(i32 %1, i32 -1)
  %5 = getelementptr inbounds i32, ptr %0, i32 %custom3
  store i32 0, ptr %5, align 4, !tbaa !23
  br label %21

6:                                                ; preds = %10, %2
  %7 = phi i32 [ %custom32, %10 ], [ 1, %2 ]
  %custom31 = call i32 @llvm.riscv.custom3(i32 %7, i32 -1)
  %custom32 = call i32 @llvm.riscv.custom3(i32 %7, i32 1)
  br label %12

8:                                                ; preds = %10
  %custom33 = call i32 @llvm.riscv.custom3(i32 %1, i32 -1)
  %9 = getelementptr inbounds i32, ptr %0, i32 %custom33
  store i32 0, ptr %9, align 4, !tbaa !23
  br i1 %3, label %19, label %21

10:                                               ; preds = %12
  %11 = icmp slt i32 %custom32, %1
  br i1 %11, label %6, label %8, !llvm.loop !25

12:                                               ; preds = %12, %6
  %13 = phi i32 [ 0, %6 ], [ %custom35, %12 ]
  %custom34 = call i32 @llvm.riscv.custom3(i32 %custom31, i32 %13)
  %14 = getelementptr inbounds i32, ptr %0, i32 %custom34
  %15 = load i32, ptr %14, align 4, !tbaa !23
  %custom35 = call i32 @llvm.riscv.custom3(i32 %13, i32 %custom32)
  %custom36 = call i32 @llvm.riscv.custom3(i32 %custom35, i32 -1)
  %16 = getelementptr inbounds i32, ptr %0, i32 %custom36
  %17 = load i32, ptr %16, align 4, !tbaa !23
  %custom37 = call i32 @llvm.riscv.custom3(i32 %17, i32 %15)
  store i32 %custom37, ptr %16, align 4, !tbaa !23
  %18 = icmp slt i32 %custom35, %1
  br i1 %18, label %12, label %10, !llvm.loop !26

19:                                               ; preds = %22, %8
  %20 = phi i32 [ %custom38, %22 ], [ %1, %8 ]
  %custom38 = call i32 @llvm.riscv.custom3(i32 %20, i32 1)
  %custom39 = call i32 @llvm.riscv.custom3(i32 %custom38, i32 -1)
  %custom310 = call i32 @llvm.riscv.custom3(i32 %20, i32 -2)
  br label %24

21:                                               ; preds = %22, %8, %4
  ret void

22:                                               ; preds = %24
  %23 = icmp ult i32 %20, 4
  br i1 %23, label %21, label %19, !llvm.loop !27

24:                                               ; preds = %24, %19
  %25 = phi i32 [ 0, %19 ], [ %custom312, %24 ]
  %custom311 = call i32 @llvm.riscv.custom3(i32 %custom39, i32 %25)
  %26 = getelementptr inbounds i32, ptr %0, i32 %custom311
  %27 = load i32, ptr %26, align 4, !tbaa !23
  %custom312 = call i32 @llvm.riscv.custom3(i32 %25, i32 %custom310)
  %custom313 = call i32 @llvm.riscv.custom3(i32 %custom312, i32 -1)
  %28 = getelementptr inbounds i32, ptr %0, i32 %custom313
  %29 = load i32, ptr %28, align 4, !tbaa !23
  store i32 %29, ptr %26, align 4, !tbaa !23
  %custom314 = call i32 @llvm.riscv.custom3(i32 %29, i32 %27)
  store i32 %custom314, ptr %28, align 4, !tbaa !23
  %30 = icmp slt i32 %custom312, %1
  br i1 %30, label %24, label %22, !llvm.loop !28
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 {
  br label %1

1:                                                ; preds = %31, %0
  %2 = phi i32 [ 0, %0 ], [ %custom36, %31 ]
  br label %29

3:                                                ; preds = %31, %7
  %4 = phi i32 [ %custom3, %7 ], [ 0, %31 ]
  br label %5

5:                                                ; preds = %11, %3
  %6 = phi i32 [ 0, %3 ], [ %custom31, %11 ]
  br label %9

7:                                                ; preds = %11
  %custom3 = call i32 @llvm.riscv.custom3(i32 %4, i32 1)
  %8 = icmp eq i32 %custom3, 64
  br i1 %8, label %25, label %3, !llvm.loop !5

9:                                                ; preds = %13, %5
  %10 = phi i32 [ 0, %5 ], [ %custom32, %13 ]
  br label %16

11:                                               ; preds = %13
  %custom31 = call i32 @llvm.riscv.custom3(i32 %6, i32 1)
  %12 = icmp eq i32 %custom31, 64
  br i1 %12, label %7, label %5, !llvm.loop !7

13:                                               ; preds = %16
  %14 = getelementptr inbounds [64 x [64 x float]], ptr @main.C, i32 %4, i32 %6, i32 %10
  store float %23, ptr %14, align 4, !tbaa !8
  %custom32 = call i32 @llvm.riscv.custom3(i32 %10, i32 1)
  %15 = icmp eq i32 %custom32, 64
  br i1 %15, label %11, label %9, !llvm.loop !12

16:                                               ; preds = %16, %9
  %17 = phi i32 [ 0, %9 ], [ %custom33, %16 ]
  %18 = phi float [ 0.000000e+00, %9 ], [ %23, %16 ]
  %19 = getelementptr inbounds [64 x [64 x float]], ptr @main.A, i32 %4, i32 %6, i32 %17
  %20 = load float, ptr %19, align 4, !tbaa !8
  %21 = getelementptr inbounds [64 x [64 x float]], ptr @main.B, i32 %4, i32 %17, i32 %10
  %22 = load float, ptr %21, align 4, !tbaa !8
  %23 = tail call float @llvm.fmuladd.f32(float %20, float %22, float %18)
  %custom33 = call i32 @llvm.riscv.custom3(i32 %17, i32 1)
  %24 = icmp eq i32 %custom33, 64
  br i1 %24, label %13, label %16, !llvm.loop !13

25:                                               ; preds = %7
  %26 = load float, ptr @main.C, align 4, !tbaa !8
  %27 = fpext float %26 to double
  %28 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef %27)
  br label %44

29:                                               ; preds = %33, %1
  %30 = phi i32 [ 0, %1 ], [ %custom37, %33 ]
  %custom34 = call i32 @llvm.riscv.custom3(i32 %30, i32 %2)
  %custom35 = call i32 @llvm.riscv.custom3(i32 %2, i32 %30)
  br label %35

31:                                               ; preds = %33
  %custom36 = call i32 @llvm.riscv.custom3(i32 %2, i32 1)
  %32 = icmp eq i32 %custom36, 64
  br i1 %32, label %3, label %1, !llvm.loop !29

33:                                               ; preds = %35
  %custom37 = call i32 @llvm.riscv.custom3(i32 %30, i32 1)
  %34 = icmp eq i32 %custom37, 64
  br i1 %34, label %31, label %29, !llvm.loop !30

35:                                               ; preds = %35, %29
  %36 = phi i32 [ 0, %29 ], [ %custom312, %35 ]
  %custom38 = call i32 @llvm.riscv.custom3(i32 %custom34, i32 %36)
  %custom39 = call i32 @llvm.riscv.custom3(i32 %custom38, i32 7)
  %37 = sitofp i32 %custom39 to float
  %38 = fmul float %37, 0x3F847AE140000000
  %39 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.A, i32 0, i32 %2, i32 %30, i32 %36
  store float %38, ptr %39, align 4, !tbaa !8
  %custom310 = call i32 @llvm.riscv.custom3(i32 %custom35, i32 %36)
  %custom311 = call i32 @llvm.riscv.custom3(i32 %custom310, i32 3)
  %40 = sitofp i32 %custom311 to float
  %41 = fmul float %40, 0x3F947AE140000000
  %42 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.B, i32 0, i32 %2, i32 %30, i32 %36
  store float %41, ptr %42, align 4, !tbaa !8
  %custom312 = call i32 @llvm.riscv.custom3(i32 %36, i32 1)
  %43 = icmp eq i32 %custom312, 64
  br i1 %43, label %33, label %35, !llvm.loop !31

44:                                               ; preds = %44, %25
  %45 = phi i32 [ 0, %25 ], [ %custom313, %44 ]
  %46 = sitofp i32 %45 to float
  %47 = fmul float %46, 0x3F847AE140000000
  %48 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 0, i32 0
  store float %47, ptr %48, align 4, !tbaa !8
  %custom313 = call i32 @llvm.riscv.custom3(i32 %45, i32 1)
  %49 = sitofp i32 %custom313 to float
  %50 = fmul float %49, 0x3F847AE140000000
  %51 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 0, i32 1
  store float %50, ptr %51, align 4, !tbaa !8
  %custom314 = call i32 @llvm.riscv.custom3(i32 %45, i32 2)
  %52 = sitofp i32 %custom314 to float
  %53 = fmul float %52, 0x3F847AE140000000
  %54 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 0, i32 2
  store float %53, ptr %54, align 4, !tbaa !8
  %custom315 = call i32 @llvm.riscv.custom3(i32 %45, i32 3)
  %55 = sitofp i32 %custom315 to float
  %56 = fmul float %55, 0x3F847AE140000000
  %57 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 0, i32 3
  store float %56, ptr %57, align 4, !tbaa !8
  %custom316 = call i32 @llvm.riscv.custom3(i32 %45, i32 4)
  %58 = sitofp i32 %custom316 to float
  %59 = fmul float %58, 0x3F847AE140000000
  %60 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 0, i32 4
  store float %59, ptr %60, align 4, !tbaa !8
  %61 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 1, i32 0
  store float %50, ptr %61, align 4, !tbaa !8
  %custom317 = call i32 @llvm.riscv.custom3(i32 %45, i32 2)
  %62 = sitofp i32 %custom317 to float
  %63 = fmul float %62, 0x3F847AE140000000
  %64 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 1, i32 1
  store float %63, ptr %64, align 4, !tbaa !8
  %custom318 = call i32 @llvm.riscv.custom3(i32 %45, i32 3)
  %65 = sitofp i32 %custom318 to float
  %66 = fmul float %65, 0x3F847AE140000000
  %67 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 1, i32 2
  store float %66, ptr %67, align 4, !tbaa !8
  %custom319 = call i32 @llvm.riscv.custom3(i32 %45, i32 4)
  %68 = sitofp i32 %custom319 to float
  %69 = fmul float %68, 0x3F847AE140000000
  %70 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 1, i32 3
  store float %69, ptr %70, align 4, !tbaa !8
  %custom320 = call i32 @llvm.riscv.custom3(i32 %45, i32 5)
  %71 = sitofp i32 %custom320 to float
  %72 = fmul float %71, 0x3F847AE140000000
  %73 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 1, i32 4
  store float %72, ptr %73, align 4, !tbaa !8
  %74 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 2, i32 0
  store float %53, ptr %74, align 4, !tbaa !8
  %custom321 = call i32 @llvm.riscv.custom3(i32 %45, i32 3)
  %75 = sitofp i32 %custom321 to float
  %76 = fmul float %75, 0x3F847AE140000000
  %77 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 2, i32 1
  store float %76, ptr %77, align 4, !tbaa !8
  %custom322 = call i32 @llvm.riscv.custom3(i32 %45, i32 4)
  %78 = sitofp i32 %custom322 to float
  %79 = fmul float %78, 0x3F847AE140000000
  %80 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 2, i32 2
  store float %79, ptr %80, align 4, !tbaa !8
  %custom323 = call i32 @llvm.riscv.custom3(i32 %45, i32 5)
  %81 = sitofp i32 %custom323 to float
  %82 = fmul float %81, 0x3F847AE140000000
  %83 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 2, i32 3
  store float %82, ptr %83, align 4, !tbaa !8
  %custom324 = call i32 @llvm.riscv.custom3(i32 %45, i32 6)
  %84 = sitofp i32 %custom324 to float
  %85 = fmul float %84, 0x3F847AE140000000
  %86 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 2, i32 4
  store float %85, ptr %86, align 4, !tbaa !8
  %87 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 3, i32 0
  store float %56, ptr %87, align 4, !tbaa !8
  %custom325 = call i32 @llvm.riscv.custom3(i32 %45, i32 4)
  %88 = sitofp i32 %custom325 to float
  %89 = fmul float %88, 0x3F847AE140000000
  %90 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 3, i32 1
  store float %89, ptr %90, align 4, !tbaa !8
  %custom326 = call i32 @llvm.riscv.custom3(i32 %45, i32 5)
  %91 = sitofp i32 %custom326 to float
  %92 = fmul float %91, 0x3F847AE140000000
  %93 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 3, i32 2
  store float %92, ptr %93, align 4, !tbaa !8
  %custom327 = call i32 @llvm.riscv.custom3(i32 %45, i32 6)
  %94 = sitofp i32 %custom327 to float
  %95 = fmul float %94, 0x3F847AE140000000
  %96 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 3, i32 3
  store float %95, ptr %96, align 4, !tbaa !8
  %custom328 = call i32 @llvm.riscv.custom3(i32 %45, i32 7)
  %97 = sitofp i32 %custom328 to float
  %98 = fmul float %97, 0x3F847AE140000000
  %99 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 3, i32 4
  store float %98, ptr %99, align 4, !tbaa !8
  %100 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 4, i32 0
  store float %59, ptr %100, align 4, !tbaa !8
  %custom329 = call i32 @llvm.riscv.custom3(i32 %45, i32 5)
  %101 = sitofp i32 %custom329 to float
  %102 = fmul float %101, 0x3F847AE140000000
  %103 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 4, i32 1
  store float %102, ptr %103, align 4, !tbaa !8
  %custom330 = call i32 @llvm.riscv.custom3(i32 %45, i32 6)
  %104 = sitofp i32 %custom330 to float
  %105 = fmul float %104, 0x3F847AE140000000
  %106 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 4, i32 2
  store float %105, ptr %106, align 4, !tbaa !8
  %custom331 = call i32 @llvm.riscv.custom3(i32 %45, i32 7)
  %107 = sitofp i32 %custom331 to float
  %108 = fmul float %107, 0x3F847AE140000000
  %109 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 4, i32 3
  store float %108, ptr %109, align 4, !tbaa !8
  %custom332 = call i32 @llvm.riscv.custom3(i32 %45, i32 8)
  %110 = sitofp i32 %custom332 to float
  %111 = fmul float %110, 0x3F847AE140000000
  %112 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %45, i32 4, i32 4
  store float %111, ptr %112, align 4, !tbaa !8
  %113 = icmp eq i32 %custom313, 16
  br i1 %113, label %114, label %44, !llvm.loop !32

114:                                              ; preds = %44
  tail call void @conv2d(ptr noundef nonnull @main.IN, ptr noundef nonnull @main.Wt, ptr noundef nonnull @main.O)
  %115 = load float, ptr @main.O, align 4, !tbaa !8
  %116 = fpext float %115 to double
  %117 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef %116)
  br label %125

118:                                              ; preds = %125
  tail call void @fft_4096(ptr noundef nonnull @main.sig)
  %119 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1), align 4
  %120 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1, i32 1), align 4
  %121 = fpext float %119 to double
  %122 = fpext float %120 to double
  %123 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef %121, double noundef %122)
  %124 = tail call noalias dereferenceable_or_null(16384) ptr @malloc(i32 noundef 16384) #12
  br label %140

125:                                              ; preds = %125, %114
  %126 = phi i32 [ 0, %114 ], [ %custom333, %125 ]
  %127 = sitofp i32 %126 to double
  %128 = fmul double %127, 0x4073A28C59D5433B
  %129 = fmul double %128, 0x3F30000000000000
  %130 = tail call double @sin(double noundef %129) #11
  %131 = fptrunc double %130 to float
  %132 = getelementptr inbounds [4096 x { float, float }], ptr @main.sig, i32 0, i32 %126
  %133 = getelementptr inbounds [4096 x { float, float }], ptr @main.sig, i32 0, i32 %126, i32 1
  store float %131, ptr %132, align 4
  store float 0.000000e+00, ptr %133, align 4
  %custom333 = call i32 @llvm.riscv.custom3(i32 %126, i32 1)
  %134 = icmp eq i32 %custom333, 4096
  br i1 %134, label %118, label %125, !llvm.loop !33

135:                                              ; preds = %140
  tail call void @gelu_layernorm(ptr noundef nonnull %124, i32 noundef 4096)
  %136 = load float, ptr %124, align 4, !tbaa !8
  %137 = fpext float %136 to double
  %138 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef %137)
  %139 = tail call noalias dereferenceable_or_null(16384) ptr @malloc(i32 noundef 16384) #12
  br label %174

140:                                              ; preds = %140, %118
  %141 = phi i32 [ 0, %118 ], [ %custom334, %140 ]
  %142 = sitofp i32 %141 to float
  %143 = fmul float %142, 0x3F40000000000000
  %144 = fadd float %143, -1.000000e+00
  %145 = getelementptr inbounds float, ptr %124, i32 %141
  store float %144, ptr %145, align 4, !tbaa !8
  %custom334 = call i32 @llvm.riscv.custom3(i32 %141, i32 1)
  %146 = icmp eq i32 %custom334, 4096
  br i1 %146, label %135, label %140, !llvm.loop !34

147:                                              ; preds = %174, %151
  %148 = phi i32 [ %custom336, %151 ], [ 1, %174 ]
  %custom335 = call i32 @llvm.riscv.custom3(i32 %148, i32 -1)
  %custom336 = call i32 @llvm.riscv.custom3(i32 %148, i32 1)
  br label %153

149:                                              ; preds = %151
  %150 = getelementptr inbounds i32, ptr %139, i32 4095
  store i32 0, ptr %150, align 4, !tbaa !23
  br label %160

151:                                              ; preds = %153
  %152 = icmp slt i32 %custom336, 4096
  br i1 %152, label %147, label %149, !llvm.loop !25

153:                                              ; preds = %153, %147
  %154 = phi i32 [ 0, %147 ], [ %custom338, %153 ]
  %custom337 = call i32 @llvm.riscv.custom3(i32 %custom335, i32 %154)
  %155 = getelementptr inbounds i32, ptr %139, i32 %custom337
  %156 = load i32, ptr %155, align 4, !tbaa !23
  %custom338 = call i32 @llvm.riscv.custom3(i32 %154, i32 %custom336)
  %custom339 = call i32 @llvm.riscv.custom3(i32 %custom338, i32 -1)
  %157 = getelementptr inbounds i32, ptr %139, i32 %custom339
  %158 = load i32, ptr %157, align 4, !tbaa !23
  %custom340 = call i32 @llvm.riscv.custom3(i32 %158, i32 %156)
  store i32 %custom340, ptr %157, align 4, !tbaa !23
  %159 = icmp slt i32 %custom338, 4096
  br i1 %159, label %153, label %151, !llvm.loop !26

160:                                              ; preds = %162, %149
  %161 = phi i32 [ 4096, %149 ], [ %custom341, %162 ]
  %custom341 = call i32 @llvm.riscv.custom3(i32 %161, i32 1)
  %custom342 = call i32 @llvm.riscv.custom3(i32 %custom341, i32 -1)
  %custom343 = call i32 @llvm.riscv.custom3(i32 %161, i32 8190)
  br label %164

162:                                              ; preds = %164
  %163 = icmp ult i32 %161, 4
  br i1 %163, label %171, label %160, !llvm.loop !27

164:                                              ; preds = %164, %160
  %165 = phi i32 [ 0, %160 ], [ %custom345, %164 ]
  %custom344 = call i32 @llvm.riscv.custom3(i32 %custom342, i32 %165)
  %166 = getelementptr inbounds i32, ptr %139, i32 %custom344
  %167 = load i32, ptr %166, align 4, !tbaa !23
  %custom345 = call i32 @llvm.riscv.custom3(i32 %165, i32 %custom343)
  %custom346 = call i32 @llvm.riscv.custom3(i32 %custom345, i32 -1)
  %168 = getelementptr inbounds i32, ptr %139, i32 %custom346
  %169 = load i32, ptr %168, align 4, !tbaa !23
  store i32 %169, ptr %166, align 4, !tbaa !23
  %custom347 = call i32 @llvm.riscv.custom3(i32 %169, i32 %167)
  store i32 %custom347, ptr %168, align 4, !tbaa !23
  %170 = icmp ult i32 %custom345, 4096
  br i1 %170, label %164, label %162, !llvm.loop !28

171:                                              ; preds = %162
  %172 = load i32, ptr %150, align 4, !tbaa !23
  %173 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef 4095, i32 noundef %172)
  tail call void @free(ptr noundef %124)
  tail call void @free(ptr noundef nonnull %139)
  ret i32 0

174:                                              ; preds = %174, %135
  %175 = phi i32 [ 0, %135 ], [ %custom348, %174 ]
  %176 = getelementptr inbounds i32, ptr %139, i32 %175
  store i32 1, ptr %176, align 4, !tbaa !23
  %custom348 = call i32 @llvm.riscv.custom3(i32 %175, i32 1)
  %177 = icmp eq i32 %custom348, 4096
  br i1 %177, label %147, label %174, !llvm.loop !35
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare dso_local double @sin(double noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare dso_local noalias noundef ptr @malloc(i32 noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare dso_local void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #1

; Function Attrs: nounwind memory(none)
declare i32 @llvm.riscv.custom3(i32, i32) #10

attributes #0 = { nofree nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "offload.target"="custom-accel" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind uwtable "no-trapping-math"="true" "offload.target"="custom-accel" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nofree nounwind memory(write, argmem: readwrite) uwtable "no-trapping-math"="true" "offload.target"="custom-accel" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { mustprogress nofree nounwind willreturn memory(write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #6 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "offload.target"="custom-accel" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #7 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #9 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #10 = { nounwind memory(none) }
attributes #11 = { nounwind }
attributes #12 = { allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"ilp32"}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 8, !"SmallDataLimit", i32 8}
!4 = !{!"clang version 17.0.2 (https://github.com/llvm/llvm-project.git b2417f51dbbd7435eb3aaf203de24de6754da50e)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = distinct !{!12, !6}
!13 = distinct !{!13, !6}
!14 = distinct !{!14, !6}
!15 = distinct !{!15, !6}
!16 = distinct !{!16, !6}
!17 = distinct !{!17, !6}
!18 = distinct !{!18, !6}
!19 = !{!"branch_weights", i32 1, i32 1048575}
!20 = distinct !{!20, !6}
!21 = distinct !{!21, !6}
!22 = distinct !{!22, !6}
!23 = !{!24, !24, i64 0}
!24 = !{!"int", !10, i64 0}
!25 = distinct !{!25, !6}
!26 = distinct !{!26, !6}
!27 = distinct !{!27, !6}
!28 = distinct !{!28, !6}
!29 = distinct !{!29, !6}
!30 = distinct !{!30, !6}
!31 = distinct !{!31, !6}
!32 = distinct !{!32, !6}
!33 = distinct !{!33, !6}
!34 = distinct !{!34, !6}
!35 = distinct !{!35, !6}
