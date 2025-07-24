; ModuleID = 'heavy_ops.c'
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
define dso_local void @batched_gemm(ptr nocapture noundef readonly %0, ptr nocapture noundef readonly %1, ptr nocapture noundef writeonly %2) local_unnamed_addr #0 {
  br label %4

4:                                                ; preds = %3, %9
  %5 = phi i32 [ 0, %3 ], [ %10, %9 ]
  br label %7

6:                                                ; preds = %9
  ret void

7:                                                ; preds = %4, %14
  %8 = phi i32 [ 0, %4 ], [ %15, %14 ]
  br label %12

9:                                                ; preds = %14
  %10 = add nuw nsw i32 %5, 1
  %11 = icmp eq i32 %10, 64
  br i1 %11, label %6, label %4, !llvm.loop !5

12:                                               ; preds = %7, %17
  %13 = phi i32 [ 0, %7 ], [ %19, %17 ]
  br label %21

14:                                               ; preds = %17
  %15 = add nuw nsw i32 %8, 1
  %16 = icmp eq i32 %15, 64
  br i1 %16, label %9, label %7, !llvm.loop !7

17:                                               ; preds = %21
  %18 = getelementptr inbounds [64 x [64 x float]], ptr %2, i32 %5, i32 %8, i32 %13
  store float %28, ptr %18, align 4, !tbaa !8
  %19 = add nuw nsw i32 %13, 1
  %20 = icmp eq i32 %19, 64
  br i1 %20, label %14, label %12, !llvm.loop !12

21:                                               ; preds = %12, %21
  %22 = phi i32 [ 0, %12 ], [ %29, %21 ]
  %23 = phi float [ 0.000000e+00, %12 ], [ %28, %21 ]
  %24 = getelementptr inbounds [64 x [64 x float]], ptr %0, i32 %5, i32 %8, i32 %22
  %25 = load float, ptr %24, align 4, !tbaa !8
  %26 = getelementptr inbounds [64 x [64 x float]], ptr %1, i32 %5, i32 %22, i32 %13
  %27 = load float, ptr %26, align 4, !tbaa !8
  %28 = tail call float @llvm.fmuladd.f32(float %25, float %27, float %23)
  %29 = add nuw nsw i32 %22, 1
  %30 = icmp eq i32 %29, 64
  br i1 %30, label %17, label %21, !llvm.loop !13
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nofree nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @conv2d(ptr nocapture noundef readonly %0, ptr nocapture noundef readonly %1, ptr nocapture noundef writeonly %2) local_unnamed_addr #0 {
  br label %4

4:                                                ; preds = %3, %17
  %5 = phi i32 [ 0, %3 ], [ %6, %17 ]
  %6 = add nuw nsw i32 %5, 1
  %7 = add nuw nsw i32 %5, 2
  %8 = add nuw nsw i32 %5, 3
  %9 = add nuw nsw i32 %5, 4
  br label %11

10:                                               ; preds = %17
  ret void

11:                                               ; preds = %4, %149
  %12 = phi i32 [ 0, %4 ], [ %13, %149 ]
  %13 = add nuw nsw i32 %12, 1
  %14 = add nuw nsw i32 %12, 2
  %15 = add nuw nsw i32 %12, 3
  %16 = add nuw nsw i32 %12, 4
  br label %19

17:                                               ; preds = %149
  %18 = icmp eq i32 %6, 32
  br i1 %18, label %10, label %4, !llvm.loop !14

19:                                               ; preds = %11, %19
  %20 = phi i32 [ 0, %11 ], [ %147, %19 ]
  %21 = phi float [ 0.000000e+00, %11 ], [ %146, %19 ]
  %22 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %5, i32 %12
  %23 = load float, ptr %22, align 4, !tbaa !8
  %24 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 0, i32 0
  %25 = load float, ptr %24, align 4, !tbaa !8
  %26 = tail call float @llvm.fmuladd.f32(float %23, float %25, float %21)
  %27 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %5, i32 %13
  %28 = load float, ptr %27, align 4, !tbaa !8
  %29 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 0, i32 1
  %30 = load float, ptr %29, align 4, !tbaa !8
  %31 = tail call float @llvm.fmuladd.f32(float %28, float %30, float %26)
  %32 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %5, i32 %14
  %33 = load float, ptr %32, align 4, !tbaa !8
  %34 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 0, i32 2
  %35 = load float, ptr %34, align 4, !tbaa !8
  %36 = tail call float @llvm.fmuladd.f32(float %33, float %35, float %31)
  %37 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %5, i32 %15
  %38 = load float, ptr %37, align 4, !tbaa !8
  %39 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 0, i32 3
  %40 = load float, ptr %39, align 4, !tbaa !8
  %41 = tail call float @llvm.fmuladd.f32(float %38, float %40, float %36)
  %42 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %5, i32 %16
  %43 = load float, ptr %42, align 4, !tbaa !8
  %44 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 0, i32 4
  %45 = load float, ptr %44, align 4, !tbaa !8
  %46 = tail call float @llvm.fmuladd.f32(float %43, float %45, float %41)
  %47 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %6, i32 %12
  %48 = load float, ptr %47, align 4, !tbaa !8
  %49 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 1, i32 0
  %50 = load float, ptr %49, align 4, !tbaa !8
  %51 = tail call float @llvm.fmuladd.f32(float %48, float %50, float %46)
  %52 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %6, i32 %13
  %53 = load float, ptr %52, align 4, !tbaa !8
  %54 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 1, i32 1
  %55 = load float, ptr %54, align 4, !tbaa !8
  %56 = tail call float @llvm.fmuladd.f32(float %53, float %55, float %51)
  %57 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %6, i32 %14
  %58 = load float, ptr %57, align 4, !tbaa !8
  %59 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 1, i32 2
  %60 = load float, ptr %59, align 4, !tbaa !8
  %61 = tail call float @llvm.fmuladd.f32(float %58, float %60, float %56)
  %62 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %6, i32 %15
  %63 = load float, ptr %62, align 4, !tbaa !8
  %64 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 1, i32 3
  %65 = load float, ptr %64, align 4, !tbaa !8
  %66 = tail call float @llvm.fmuladd.f32(float %63, float %65, float %61)
  %67 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %6, i32 %16
  %68 = load float, ptr %67, align 4, !tbaa !8
  %69 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 1, i32 4
  %70 = load float, ptr %69, align 4, !tbaa !8
  %71 = tail call float @llvm.fmuladd.f32(float %68, float %70, float %66)
  %72 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %7, i32 %12
  %73 = load float, ptr %72, align 4, !tbaa !8
  %74 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 2, i32 0
  %75 = load float, ptr %74, align 4, !tbaa !8
  %76 = tail call float @llvm.fmuladd.f32(float %73, float %75, float %71)
  %77 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %7, i32 %13
  %78 = load float, ptr %77, align 4, !tbaa !8
  %79 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 2, i32 1
  %80 = load float, ptr %79, align 4, !tbaa !8
  %81 = tail call float @llvm.fmuladd.f32(float %78, float %80, float %76)
  %82 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %7, i32 %14
  %83 = load float, ptr %82, align 4, !tbaa !8
  %84 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 2, i32 2
  %85 = load float, ptr %84, align 4, !tbaa !8
  %86 = tail call float @llvm.fmuladd.f32(float %83, float %85, float %81)
  %87 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %7, i32 %15
  %88 = load float, ptr %87, align 4, !tbaa !8
  %89 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 2, i32 3
  %90 = load float, ptr %89, align 4, !tbaa !8
  %91 = tail call float @llvm.fmuladd.f32(float %88, float %90, float %86)
  %92 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %7, i32 %16
  %93 = load float, ptr %92, align 4, !tbaa !8
  %94 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 2, i32 4
  %95 = load float, ptr %94, align 4, !tbaa !8
  %96 = tail call float @llvm.fmuladd.f32(float %93, float %95, float %91)
  %97 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %8, i32 %12
  %98 = load float, ptr %97, align 4, !tbaa !8
  %99 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 3, i32 0
  %100 = load float, ptr %99, align 4, !tbaa !8
  %101 = tail call float @llvm.fmuladd.f32(float %98, float %100, float %96)
  %102 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %8, i32 %13
  %103 = load float, ptr %102, align 4, !tbaa !8
  %104 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 3, i32 1
  %105 = load float, ptr %104, align 4, !tbaa !8
  %106 = tail call float @llvm.fmuladd.f32(float %103, float %105, float %101)
  %107 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %8, i32 %14
  %108 = load float, ptr %107, align 4, !tbaa !8
  %109 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 3, i32 2
  %110 = load float, ptr %109, align 4, !tbaa !8
  %111 = tail call float @llvm.fmuladd.f32(float %108, float %110, float %106)
  %112 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %8, i32 %15
  %113 = load float, ptr %112, align 4, !tbaa !8
  %114 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 3, i32 3
  %115 = load float, ptr %114, align 4, !tbaa !8
  %116 = tail call float @llvm.fmuladd.f32(float %113, float %115, float %111)
  %117 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %8, i32 %16
  %118 = load float, ptr %117, align 4, !tbaa !8
  %119 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 3, i32 4
  %120 = load float, ptr %119, align 4, !tbaa !8
  %121 = tail call float @llvm.fmuladd.f32(float %118, float %120, float %116)
  %122 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %9, i32 %12
  %123 = load float, ptr %122, align 4, !tbaa !8
  %124 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 4, i32 0
  %125 = load float, ptr %124, align 4, !tbaa !8
  %126 = tail call float @llvm.fmuladd.f32(float %123, float %125, float %121)
  %127 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %9, i32 %13
  %128 = load float, ptr %127, align 4, !tbaa !8
  %129 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 4, i32 1
  %130 = load float, ptr %129, align 4, !tbaa !8
  %131 = tail call float @llvm.fmuladd.f32(float %128, float %130, float %126)
  %132 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %9, i32 %14
  %133 = load float, ptr %132, align 4, !tbaa !8
  %134 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 4, i32 2
  %135 = load float, ptr %134, align 4, !tbaa !8
  %136 = tail call float @llvm.fmuladd.f32(float %133, float %135, float %131)
  %137 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %9, i32 %15
  %138 = load float, ptr %137, align 4, !tbaa !8
  %139 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 4, i32 3
  %140 = load float, ptr %139, align 4, !tbaa !8
  %141 = tail call float @llvm.fmuladd.f32(float %138, float %140, float %136)
  %142 = getelementptr inbounds [36 x [36 x float]], ptr %0, i32 %20, i32 %9, i32 %16
  %143 = load float, ptr %142, align 4, !tbaa !8
  %144 = getelementptr inbounds [5 x [5 x float]], ptr %1, i32 %20, i32 4, i32 4
  %145 = load float, ptr %144, align 4, !tbaa !8
  %146 = tail call float @llvm.fmuladd.f32(float %143, float %145, float %141)
  %147 = add nuw nsw i32 %20, 1
  %148 = icmp eq i32 %147, 16
  br i1 %148, label %149, label %19, !llvm.loop !15

149:                                              ; preds = %19
  %150 = getelementptr inbounds [32 x float], ptr %2, i32 %5, i32 %12
  store float %146, ptr %150, align 4, !tbaa !8
  %151 = icmp eq i32 %13, 32
  br i1 %151, label %17, label %11, !llvm.loop !16
}

; Function Attrs: nounwind uwtable
define dso_local void @fft_4096(ptr nocapture noundef %0) local_unnamed_addr #2 {
  %2 = alloca { double, double }, align 8
  %3 = alloca { double, double }, align 8
  %4 = alloca { double, double }, align 8
  %5 = getelementptr inbounds { double, double }, ptr %2, i32 0, i32 1
  %6 = getelementptr inbounds { double, double }, ptr %4, i32 0, i32 1
  %7 = getelementptr inbounds { double, double }, ptr %3, i32 0, i32 1
  br label %9

8:                                                ; preds = %23
  ret void

9:                                                ; preds = %1, %23
  %10 = phi i32 [ 1, %1 ], [ %24, %23 ]
  %11 = shl nuw nsw i32 1, %10
  %12 = lshr exact i32 %11, 1
  %13 = sitofp i32 %12 to double
  call void @__divdc3(ptr nonnull sret({ double, double }) align 8 %2, double noundef -0.000000e+00, double noundef 0xC00921FB54442D18, double noundef %13, double noundef 0.000000e+00) #11
  %14 = load double, ptr %2, align 8
  %15 = load double, ptr %5, align 8
  store double %14, ptr %4, align 8
  store double %15, ptr %6, align 8
  call void @cexp(ptr nonnull sret({ double, double }) align 8 %3, ptr noundef nonnull %4) #11
  %16 = load double, ptr %3, align 8
  %17 = load double, ptr %7, align 8
  %18 = fptrunc double %16 to float
  %19 = fptrunc double %17 to float
  %20 = call i32 @llvm.umax.i32(i32 %12, i32 1)
  br label %21

21:                                               ; preds = %26, %9
  %22 = phi i32 [ 0, %9 ], [ %27, %26 ]
  br label %29

23:                                               ; preds = %26
  %24 = add nuw nsw i32 %10, 1
  %25 = icmp eq i32 %24, 13
  br i1 %25, label %8, label %9, !llvm.loop !17

26:                                               ; preds = %80
  %27 = add nuw nsw i32 %22, %11
  %28 = icmp ult i32 %27, 4096
  br i1 %28, label %21, label %23, !llvm.loop !18

29:                                               ; preds = %21, %80
  %30 = phi float [ %82, %80 ], [ 0.000000e+00, %21 ]
  %31 = phi float [ %81, %80 ], [ 1.000000e+00, %21 ]
  %32 = phi i32 [ %83, %80 ], [ 0, %21 ]
  %33 = add nuw nsw i32 %32, %22
  %34 = add nuw nsw i32 %33, %12
  %35 = getelementptr inbounds { float, float }, ptr %0, i32 %34
  %36 = load float, ptr %35, align 4
  %37 = getelementptr inbounds { float, float }, ptr %0, i32 %34, i32 1
  %38 = load float, ptr %37, align 4
  %39 = fmul float %31, %36
  %40 = fmul float %30, %38
  %41 = fmul float %31, %38
  %42 = fmul float %30, %36
  %43 = fsub float %39, %40
  %44 = fadd float %42, %41
  %45 = fcmp uno float %43, 0.000000e+00
  br i1 %45, label %46, label %54, !prof !19

46:                                               ; preds = %29
  %47 = fcmp uno float %44, 0.000000e+00
  br i1 %47, label %48, label %54, !prof !19

48:                                               ; preds = %46
  %49 = call [2 x i32] @__mulsc3(float noundef %31, float noundef %30, float noundef %36, float noundef %38) #11
  %50 = extractvalue [2 x i32] %49, 0
  %51 = bitcast i32 %50 to float
  %52 = extractvalue [2 x i32] %49, 1
  %53 = bitcast i32 %52 to float
  br label %54

54:                                               ; preds = %48, %46, %29
  %55 = phi float [ %43, %29 ], [ %43, %46 ], [ %51, %48 ]
  %56 = phi float [ %44, %29 ], [ %44, %46 ], [ %53, %48 ]
  %57 = getelementptr inbounds { float, float }, ptr %0, i32 %33
  %58 = load float, ptr %57, align 4
  %59 = getelementptr inbounds { float, float }, ptr %0, i32 %33, i32 1
  %60 = load float, ptr %59, align 4
  %61 = fadd float %55, %58
  %62 = fadd float %56, %60
  store float %61, ptr %57, align 4
  store float %62, ptr %59, align 4
  %63 = fsub float %58, %55
  %64 = fsub float %60, %56
  store float %63, ptr %35, align 4
  store float %64, ptr %37, align 4
  %65 = fmul float %31, %18
  %66 = fmul float %30, %19
  %67 = fmul float %31, %19
  %68 = fmul float %30, %18
  %69 = fsub float %65, %66
  %70 = fadd float %67, %68
  %71 = fcmp uno float %69, 0.000000e+00
  br i1 %71, label %72, label %80, !prof !19

72:                                               ; preds = %54
  %73 = fcmp uno float %70, 0.000000e+00
  br i1 %73, label %74, label %80, !prof !19

74:                                               ; preds = %72
  %75 = call [2 x i32] @__mulsc3(float noundef %31, float noundef %30, float noundef %18, float noundef %19) #11
  %76 = extractvalue [2 x i32] %75, 0
  %77 = bitcast i32 %76 to float
  %78 = extractvalue [2 x i32] %75, 1
  %79 = bitcast i32 %78 to float
  br label %80

80:                                               ; preds = %74, %72, %54
  %81 = phi float [ %69, %54 ], [ %69, %72 ], [ %77, %74 ]
  %82 = phi float [ %70, %54 ], [ %70, %72 ], [ %79, %74 ]
  %83 = add nuw nsw i32 %32, 1
  %84 = icmp eq i32 %83, %20
  br i1 %84, label %26, label %29, !llvm.loop !20
}

; Function Attrs: nounwind
declare dso_local void @cexp(ptr sret({ double, double }) align 8, ptr noundef) local_unnamed_addr #3

declare dso_local void @__divdc3(ptr, double, double, double, double) local_unnamed_addr

declare dso_local [2 x i32] @__mulsc3(float, float, float, float) local_unnamed_addr

; Function Attrs: nofree nounwind memory(write, argmem: readwrite) uwtable
define dso_local void @gelu_layernorm(ptr nocapture noundef %0, i32 noundef %1) local_unnamed_addr #4 {
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
  br i1 %3, label %37, label %36

15:                                               ; preds = %2, %15
  %16 = phi double [ %30, %15 ], [ 0.000000e+00, %2 ]
  %17 = phi double [ %33, %15 ], [ 0.000000e+00, %2 ]
  %18 = phi i32 [ %34, %15 ], [ 0, %2 ]
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
  %34 = add nuw nsw i32 %18, 1
  %35 = icmp eq i32 %34, %1
  br i1 %35, label %4, label %15, !llvm.loop !21

36:                                               ; preds = %37, %4
  ret void

37:                                               ; preds = %4, %37
  %38 = phi i32 [ %45, %37 ], [ 0, %4 ]
  %39 = getelementptr inbounds float, ptr %0, i32 %38
  %40 = load float, ptr %39, align 4, !tbaa !8
  %41 = fpext float %40 to double
  %42 = fsub double %41, %8
  %43 = fmul double %14, %42
  %44 = fptrunc double %43 to float
  store float %44, ptr %39, align 4, !tbaa !8
  %45 = add nuw nsw i32 %38, 1
  %46 = icmp eq i32 %45, %1
  br i1 %46, label %36, label %37, !llvm.loop !22
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare dso_local float @tanhf(float noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare dso_local double @sqrt(double noundef) local_unnamed_addr #5

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @prefix_sum(ptr nocapture noundef %0, i32 noundef %1) local_unnamed_addr #6 {
  %3 = icmp sgt i32 %1, 1
  br i1 %3, label %7, label %4

4:                                                ; preds = %2
  %5 = add nsw i32 %1, -1
  %6 = getelementptr inbounds i32, ptr %0, i32 %5
  store i32 0, ptr %6, align 4, !tbaa !23
  br label %32

7:                                                ; preds = %2, %14
  %8 = phi i32 [ %10, %14 ], [ 1, %2 ]
  %9 = add i32 %8, -1
  %10 = shl i32 %8, 1
  br label %16

11:                                               ; preds = %14
  %12 = add nsw i32 %1, -1
  %13 = getelementptr inbounds i32, ptr %0, i32 %12
  store i32 0, ptr %13, align 4, !tbaa !23
  br i1 %3, label %27, label %32

14:                                               ; preds = %16
  %15 = icmp slt i32 %10, %1
  br i1 %15, label %7, label %11, !llvm.loop !25

16:                                               ; preds = %7, %16
  %17 = phi i32 [ 0, %7 ], [ %21, %16 ]
  %18 = add i32 %9, %17
  %19 = getelementptr inbounds i32, ptr %0, i32 %18
  %20 = load i32, ptr %19, align 4, !tbaa !23
  %21 = add nsw i32 %17, %10
  %22 = add nsw i32 %21, -1
  %23 = getelementptr inbounds i32, ptr %0, i32 %22
  %24 = load i32, ptr %23, align 4, !tbaa !23
  %25 = add nsw i32 %24, %20
  store i32 %25, ptr %23, align 4, !tbaa !23
  %26 = icmp slt i32 %21, %1
  br i1 %26, label %16, label %14, !llvm.loop !26

27:                                               ; preds = %11, %33
  %28 = phi i32 [ %29, %33 ], [ %1, %11 ]
  %29 = lshr i32 %28, 1
  %30 = add nsw i32 %29, -1
  %31 = and i32 %28, -2
  br label %35

32:                                               ; preds = %33, %4, %11
  ret void

33:                                               ; preds = %35
  %34 = icmp ult i32 %28, 4
  br i1 %34, label %32, label %27, !llvm.loop !27

35:                                               ; preds = %27, %35
  %36 = phi i32 [ 0, %27 ], [ %40, %35 ]
  %37 = add i32 %30, %36
  %38 = getelementptr inbounds i32, ptr %0, i32 %37
  %39 = load i32, ptr %38, align 4, !tbaa !23
  %40 = add nuw nsw i32 %36, %31
  %41 = add nsw i32 %40, -1
  %42 = getelementptr inbounds i32, ptr %0, i32 %41
  %43 = load i32, ptr %42, align 4, !tbaa !23
  store i32 %43, ptr %38, align 4, !tbaa !23
  %44 = add nsw i32 %43, %39
  store i32 %44, ptr %42, align 4, !tbaa !23
  %45 = icmp slt i32 %40, %1
  br i1 %45, label %35, label %33, !llvm.loop !28
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 {
  br label %1

1:                                                ; preds = %0, %37
  %2 = phi i32 [ 0, %0 ], [ %38, %37 ]
  br label %33

3:                                                ; preds = %37, %7
  %4 = phi i32 [ %8, %7 ], [ 0, %37 ]
  br label %5

5:                                                ; preds = %12, %3
  %6 = phi i32 [ 0, %3 ], [ %13, %12 ]
  br label %10

7:                                                ; preds = %12
  %8 = add nuw nsw i32 %4, 1
  %9 = icmp eq i32 %8, 64
  br i1 %9, label %29, label %3, !llvm.loop !5

10:                                               ; preds = %15, %5
  %11 = phi i32 [ 0, %5 ], [ %17, %15 ]
  br label %19

12:                                               ; preds = %15
  %13 = add nuw nsw i32 %6, 1
  %14 = icmp eq i32 %13, 64
  br i1 %14, label %7, label %5, !llvm.loop !7

15:                                               ; preds = %19
  %16 = getelementptr inbounds [64 x [64 x float]], ptr @main.C, i32 %4, i32 %6, i32 %11
  store float %26, ptr %16, align 4, !tbaa !8
  %17 = add nuw nsw i32 %11, 1
  %18 = icmp eq i32 %17, 64
  br i1 %18, label %12, label %10, !llvm.loop !12

19:                                               ; preds = %19, %10
  %20 = phi i32 [ 0, %10 ], [ %27, %19 ]
  %21 = phi float [ 0.000000e+00, %10 ], [ %26, %19 ]
  %22 = getelementptr inbounds [64 x [64 x float]], ptr @main.A, i32 %4, i32 %6, i32 %20
  %23 = load float, ptr %22, align 4, !tbaa !8
  %24 = getelementptr inbounds [64 x [64 x float]], ptr @main.B, i32 %4, i32 %20, i32 %11
  %25 = load float, ptr %24, align 4, !tbaa !8
  %26 = tail call float @llvm.fmuladd.f32(float %23, float %25, float %21)
  %27 = add nuw nsw i32 %20, 1
  %28 = icmp eq i32 %27, 64
  br i1 %28, label %15, label %19, !llvm.loop !13

29:                                               ; preds = %7
  %30 = load float, ptr @main.C, align 4, !tbaa !8
  %31 = fpext float %30 to double
  %32 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef %31)
  br label %57

33:                                               ; preds = %1, %40
  %34 = phi i32 [ 0, %1 ], [ %41, %40 ]
  %35 = add nuw nsw i32 %34, %2
  %36 = sub nsw i32 %2, %34
  br label %43

37:                                               ; preds = %40
  %38 = add nuw nsw i32 %2, 1
  %39 = icmp eq i32 %38, 64
  br i1 %39, label %3, label %1, !llvm.loop !29

40:                                               ; preds = %43
  %41 = add nuw nsw i32 %34, 1
  %42 = icmp eq i32 %41, 64
  br i1 %42, label %37, label %33, !llvm.loop !30

43:                                               ; preds = %33, %43
  %44 = phi i32 [ 0, %33 ], [ %55, %43 ]
  %45 = add nuw nsw i32 %35, %44
  %46 = and i32 %45, 7
  %47 = sitofp i32 %46 to float
  %48 = fmul float %47, 0x3F847AE140000000
  %49 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.A, i32 0, i32 %2, i32 %34, i32 %44
  store float %48, ptr %49, align 4, !tbaa !8
  %50 = add nsw i32 %36, %44
  %51 = and i32 %50, 3
  %52 = sitofp i32 %51 to float
  %53 = fmul float %52, 0x3F947AE140000000
  %54 = getelementptr inbounds [64 x [64 x [64 x float]]], ptr @main.B, i32 0, i32 %2, i32 %34, i32 %44
  store float %53, ptr %54, align 4, !tbaa !8
  %55 = add nuw nsw i32 %44, 1
  %56 = icmp eq i32 %55, 64
  br i1 %56, label %40, label %43, !llvm.loop !31

57:                                               ; preds = %29, %57
  %58 = phi i32 [ 0, %29 ], [ %62, %57 ]
  %59 = sitofp i32 %58 to float
  %60 = fmul float %59, 0x3F847AE140000000
  %61 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 0, i32 0
  store float %60, ptr %61, align 4, !tbaa !8
  %62 = add nuw nsw i32 %58, 1
  %63 = sitofp i32 %62 to float
  %64 = fmul float %63, 0x3F847AE140000000
  %65 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 0, i32 1
  store float %64, ptr %65, align 4, !tbaa !8
  %66 = add nuw nsw i32 %58, 2
  %67 = sitofp i32 %66 to float
  %68 = fmul float %67, 0x3F847AE140000000
  %69 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 0, i32 2
  store float %68, ptr %69, align 4, !tbaa !8
  %70 = add nuw nsw i32 %58, 3
  %71 = sitofp i32 %70 to float
  %72 = fmul float %71, 0x3F847AE140000000
  %73 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 0, i32 3
  store float %72, ptr %73, align 4, !tbaa !8
  %74 = add nuw nsw i32 %58, 4
  %75 = sitofp i32 %74 to float
  %76 = fmul float %75, 0x3F847AE140000000
  %77 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 0, i32 4
  store float %76, ptr %77, align 4, !tbaa !8
  %78 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 1, i32 0
  store float %64, ptr %78, align 4, !tbaa !8
  %79 = add nuw nsw i32 %58, 2
  %80 = sitofp i32 %79 to float
  %81 = fmul float %80, 0x3F847AE140000000
  %82 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 1, i32 1
  store float %81, ptr %82, align 4, !tbaa !8
  %83 = add nuw nsw i32 %58, 3
  %84 = sitofp i32 %83 to float
  %85 = fmul float %84, 0x3F847AE140000000
  %86 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 1, i32 2
  store float %85, ptr %86, align 4, !tbaa !8
  %87 = add nuw nsw i32 %58, 4
  %88 = sitofp i32 %87 to float
  %89 = fmul float %88, 0x3F847AE140000000
  %90 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 1, i32 3
  store float %89, ptr %90, align 4, !tbaa !8
  %91 = add nuw nsw i32 %58, 5
  %92 = sitofp i32 %91 to float
  %93 = fmul float %92, 0x3F847AE140000000
  %94 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 1, i32 4
  store float %93, ptr %94, align 4, !tbaa !8
  %95 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 2, i32 0
  store float %68, ptr %95, align 4, !tbaa !8
  %96 = add nuw nsw i32 %58, 3
  %97 = sitofp i32 %96 to float
  %98 = fmul float %97, 0x3F847AE140000000
  %99 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 2, i32 1
  store float %98, ptr %99, align 4, !tbaa !8
  %100 = add nuw nsw i32 %58, 4
  %101 = sitofp i32 %100 to float
  %102 = fmul float %101, 0x3F847AE140000000
  %103 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 2, i32 2
  store float %102, ptr %103, align 4, !tbaa !8
  %104 = add nuw nsw i32 %58, 5
  %105 = sitofp i32 %104 to float
  %106 = fmul float %105, 0x3F847AE140000000
  %107 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 2, i32 3
  store float %106, ptr %107, align 4, !tbaa !8
  %108 = add nuw nsw i32 %58, 6
  %109 = sitofp i32 %108 to float
  %110 = fmul float %109, 0x3F847AE140000000
  %111 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 2, i32 4
  store float %110, ptr %111, align 4, !tbaa !8
  %112 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 3, i32 0
  store float %72, ptr %112, align 4, !tbaa !8
  %113 = add nuw nsw i32 %58, 4
  %114 = sitofp i32 %113 to float
  %115 = fmul float %114, 0x3F847AE140000000
  %116 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 3, i32 1
  store float %115, ptr %116, align 4, !tbaa !8
  %117 = add nuw nsw i32 %58, 5
  %118 = sitofp i32 %117 to float
  %119 = fmul float %118, 0x3F847AE140000000
  %120 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 3, i32 2
  store float %119, ptr %120, align 4, !tbaa !8
  %121 = add nuw nsw i32 %58, 6
  %122 = sitofp i32 %121 to float
  %123 = fmul float %122, 0x3F847AE140000000
  %124 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 3, i32 3
  store float %123, ptr %124, align 4, !tbaa !8
  %125 = add nuw nsw i32 %58, 7
  %126 = sitofp i32 %125 to float
  %127 = fmul float %126, 0x3F847AE140000000
  %128 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 3, i32 4
  store float %127, ptr %128, align 4, !tbaa !8
  %129 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 4, i32 0
  store float %76, ptr %129, align 4, !tbaa !8
  %130 = add nuw nsw i32 %58, 5
  %131 = sitofp i32 %130 to float
  %132 = fmul float %131, 0x3F847AE140000000
  %133 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 4, i32 1
  store float %132, ptr %133, align 4, !tbaa !8
  %134 = add nuw nsw i32 %58, 6
  %135 = sitofp i32 %134 to float
  %136 = fmul float %135, 0x3F847AE140000000
  %137 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 4, i32 2
  store float %136, ptr %137, align 4, !tbaa !8
  %138 = add nuw nsw i32 %58, 7
  %139 = sitofp i32 %138 to float
  %140 = fmul float %139, 0x3F847AE140000000
  %141 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 4, i32 3
  store float %140, ptr %141, align 4, !tbaa !8
  %142 = add nuw nsw i32 %58, 8
  %143 = sitofp i32 %142 to float
  %144 = fmul float %143, 0x3F847AE140000000
  %145 = getelementptr inbounds [16 x [5 x [5 x float]]], ptr @main.Wt, i32 0, i32 %58, i32 4, i32 4
  store float %144, ptr %145, align 4, !tbaa !8
  %146 = icmp eq i32 %62, 16
  br i1 %146, label %147, label %57, !llvm.loop !32

147:                                              ; preds = %57
  tail call void @conv2d(ptr noundef nonnull @main.IN, ptr noundef nonnull @main.Wt, ptr noundef nonnull @main.O)
  %148 = load float, ptr @main.O, align 4, !tbaa !8
  %149 = fpext float %148 to double
  %150 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef %149)
  br label %158

151:                                              ; preds = %158
  tail call void @fft_4096(ptr noundef nonnull @main.sig)
  %152 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1), align 4
  %153 = load float, ptr getelementptr inbounds ([4096 x { float, float }], ptr @main.sig, i32 0, i32 1, i32 1), align 4
  %154 = fpext float %152 to double
  %155 = fpext float %153 to double
  %156 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef %154, double noundef %155)
  %157 = tail call noalias dereferenceable_or_null(16384) ptr @malloc(i32 noundef 16384) #12
  br label %174

158:                                              ; preds = %147, %158
  %159 = phi i32 [ 0, %147 ], [ %167, %158 ]
  %160 = sitofp i32 %159 to double
  %161 = fmul double %160, 0x4073A28C59D5433B
  %162 = fmul double %161, 0x3F30000000000000
  %163 = tail call double @sin(double noundef %162) #11
  %164 = fptrunc double %163 to float
  %165 = getelementptr inbounds [4096 x { float, float }], ptr @main.sig, i32 0, i32 %159
  %166 = getelementptr inbounds [4096 x { float, float }], ptr @main.sig, i32 0, i32 %159, i32 1
  store float %164, ptr %165, align 4
  store float 0.000000e+00, ptr %166, align 4
  %167 = add nuw nsw i32 %159, 1
  %168 = icmp eq i32 %167, 4096
  br i1 %168, label %151, label %158, !llvm.loop !33

169:                                              ; preds = %174
  tail call void @gelu_layernorm(ptr noundef nonnull %157, i32 noundef 4096)
  %170 = load float, ptr %157, align 4, !tbaa !8
  %171 = fpext float %170 to double
  %172 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef %171)
  %173 = tail call noalias dereferenceable_or_null(16384) ptr @malloc(i32 noundef 16384) #12
  br label %222

174:                                              ; preds = %151, %174
  %175 = phi i32 [ 0, %151 ], [ %180, %174 ]
  %176 = sitofp i32 %175 to float
  %177 = fmul float %176, 0x3F40000000000000
  %178 = fadd float %177, -1.000000e+00
  %179 = getelementptr inbounds float, ptr %157, i32 %175
  store float %178, ptr %179, align 4, !tbaa !8
  %180 = add nuw nsw i32 %175, 1
  %181 = icmp eq i32 %180, 4096
  br i1 %181, label %169, label %174, !llvm.loop !34

182:                                              ; preds = %222, %188
  %183 = phi i32 [ %185, %188 ], [ 1, %222 ]
  %184 = add nsw i32 %183, -1
  %185 = shl i32 %183, 1
  br label %190

186:                                              ; preds = %188
  %187 = getelementptr inbounds i32, ptr %173, i32 4095
  store i32 0, ptr %187, align 4, !tbaa !23
  br label %201

188:                                              ; preds = %190
  %189 = icmp slt i32 %185, 4096
  br i1 %189, label %182, label %186, !llvm.loop !25

190:                                              ; preds = %190, %182
  %191 = phi i32 [ 0, %182 ], [ %195, %190 ]
  %192 = add i32 %184, %191
  %193 = getelementptr inbounds i32, ptr %173, i32 %192
  %194 = load i32, ptr %193, align 4, !tbaa !23
  %195 = add nsw i32 %191, %185
  %196 = add nsw i32 %195, -1
  %197 = getelementptr inbounds i32, ptr %173, i32 %196
  %198 = load i32, ptr %197, align 4, !tbaa !23
  %199 = add nsw i32 %198, %194
  store i32 %199, ptr %197, align 4, !tbaa !23
  %200 = icmp slt i32 %195, 4096
  br i1 %200, label %190, label %188, !llvm.loop !26

201:                                              ; preds = %206, %186
  %202 = phi i32 [ 4096, %186 ], [ %203, %206 ]
  %203 = lshr i32 %202, 1
  %204 = add nsw i32 %203, -1
  %205 = and i32 %202, 8190
  br label %208

206:                                              ; preds = %208
  %207 = icmp ult i32 %202, 4
  br i1 %207, label %219, label %201, !llvm.loop !27

208:                                              ; preds = %208, %201
  %209 = phi i32 [ 0, %201 ], [ %213, %208 ]
  %210 = add nuw nsw i32 %204, %209
  %211 = getelementptr inbounds i32, ptr %173, i32 %210
  %212 = load i32, ptr %211, align 4, !tbaa !23
  %213 = add nuw nsw i32 %209, %205
  %214 = add nsw i32 %213, -1
  %215 = getelementptr inbounds i32, ptr %173, i32 %214
  %216 = load i32, ptr %215, align 4, !tbaa !23
  store i32 %216, ptr %211, align 4, !tbaa !23
  %217 = add nsw i32 %216, %212
  store i32 %217, ptr %215, align 4, !tbaa !23
  %218 = icmp ult i32 %213, 4096
  br i1 %218, label %208, label %206, !llvm.loop !28

219:                                              ; preds = %206
  %220 = load i32, ptr %187, align 4, !tbaa !23
  %221 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef 4095, i32 noundef %220)
  tail call void @free(ptr noundef %157)
  tail call void @free(ptr noundef nonnull %173)
  ret i32 0

222:                                              ; preds = %169, %222
  %223 = phi i32 [ 0, %169 ], [ %225, %222 ]
  %224 = getelementptr inbounds i32, ptr %173, i32 %223
  store i32 1, ptr %224, align 4, !tbaa !23
  %225 = add nuw nsw i32 %223, 1
  %226 = icmp eq i32 %225, 4096
  br i1 %226, label %182, label %222, !llvm.loop !35
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare dso_local double @sin(double noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare dso_local noalias noundef ptr @malloc(i32 noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare dso_local void @free(ptr allocptr nocapture noundef) local_unnamed_addr #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #10

attributes #0 = { nofree nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nofree nounwind memory(write, argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { mustprogress nofree nounwind willreturn memory(write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #6 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #7 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #9 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #10 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
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
