; ModuleID = 'prim_filter.c'
source_filename = "prim_filter.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-unknown-elf"

%struct.IntVec = type { ptr, i32, i32 }

@.str = private unnamed_addr constant [10 x i8] c"input.txt\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"output.txt\00", align 1
@.str.2 = private unnamed_addr constant [37 x i8] c"count = %zu, sum = %lld, avg = %.2f\0A\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"no primes found\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.6 = private unnamed_addr constant [8 x i8] c"realloc\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.8 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.IntVec, align 4
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @vecInit(ptr noundef %2)
  call void @readInput(ptr noundef @.str, ptr noundef %2)
  %5 = getelementptr inbounds %struct.IntVec, ptr %2, i32 0, i32 0
  %6 = load ptr, ptr %5, align 4
  %7 = getelementptr inbounds %struct.IntVec, ptr %2, i32 0, i32 1
  %8 = load i32, ptr %7, align 4
  call void @qsort(ptr noundef %6, i32 noundef %8, i32 noundef 4, ptr noundef @intCmp)
  store i64 0, ptr %3, align 8
  store i32 0, ptr %4, align 4
  br label %9

9:                                                ; preds = %23, %0
  %10 = load i32, ptr %4, align 4
  %11 = getelementptr inbounds %struct.IntVec, ptr %2, i32 0, i32 1
  %12 = load i32, ptr %11, align 4
  %13 = icmp ult i32 %10, %12
  br i1 %13, label %14, label %26

14:                                               ; preds = %9
  %15 = getelementptr inbounds %struct.IntVec, ptr %2, i32 0, i32 0
  %16 = load ptr, ptr %15, align 4
  %17 = load i32, ptr %4, align 4
  %18 = getelementptr inbounds i32, ptr %16, i32 %17
  %19 = load i32, ptr %18, align 4
  %20 = sext i32 %19 to i64
  %21 = load i64, ptr %3, align 8
  %22 = add nsw i64 %21, %20
  store i64 %22, ptr %3, align 8
  br label %23

23:                                               ; preds = %14
  %24 = load i32, ptr %4, align 4
  %25 = add i32 %24, 1
  store i32 %25, ptr %4, align 4
  br label %9, !llvm.loop !6

26:                                               ; preds = %9
  call void @writeOutput(ptr noundef @.str.1, ptr noundef %2)
  %27 = getelementptr inbounds %struct.IntVec, ptr %2, i32 0, i32 1
  %28 = load i32, ptr %27, align 4
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %30, label %41

30:                                               ; preds = %26
  %31 = getelementptr inbounds %struct.IntVec, ptr %2, i32 0, i32 1
  %32 = load i32, ptr %31, align 4
  %33 = load i64, ptr %3, align 8
  %34 = load i64, ptr %3, align 8
  %35 = sitofp i64 %34 to double
  %36 = getelementptr inbounds %struct.IntVec, ptr %2, i32 0, i32 1
  %37 = load i32, ptr %36, align 4
  %38 = uitofp i32 %37 to double
  %39 = fdiv double %35, %38
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %32, i64 noundef %33, double noundef %39)
  br label %43

41:                                               ; preds = %26
  %42 = call i32 @puts(ptr noundef @.str.3)
  br label %43

43:                                               ; preds = %41, %30
  call void @vecFree(ptr noundef %2)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @vecInit(ptr noundef %0) #0 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4
  call void @llvm.memset.p0.i32(ptr align 4 %3, i8 0, i32 12, i1 false)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @readInput(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %7 = load ptr, ptr %3, align 4
  %8 = call ptr @fopen(ptr noundef %7, ptr noundef @.str.4)
  store ptr %8, ptr %5, align 4
  %9 = load ptr, ptr %5, align 4
  %10 = icmp ne ptr %9, null
  br i1 %10, label %13, label %11

11:                                               ; preds = %2
  %12 = load ptr, ptr %3, align 4
  call void @perror(ptr noundef %12)
  call void @exit(i32 noundef 1) #5
  unreachable

13:                                               ; preds = %2
  br label %14

14:                                               ; preds = %24, %13
  %15 = load ptr, ptr %5, align 4
  %16 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %15, ptr noundef @.str.5, ptr noundef %6)
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %18, label %25

18:                                               ; preds = %14
  %19 = load i32, ptr %6, align 4
  %20 = call zeroext i1 @isPrime(i32 noundef %19)
  br i1 %20, label %21, label %24

21:                                               ; preds = %18
  %22 = load ptr, ptr %4, align 4
  %23 = load i32, ptr %6, align 4
  call void @vecPush(ptr noundef %22, i32 noundef %23)
  br label %24

24:                                               ; preds = %21, %18
  br label %14, !llvm.loop !8

25:                                               ; preds = %14
  %26 = load ptr, ptr %5, align 4
  %27 = call i32 @fclose(ptr noundef %26)
  ret void
}

declare dso_local void @qsort(ptr noundef, i32 noundef, i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @intCmp(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 4
  %6 = load i32, ptr %5, align 4
  %7 = load ptr, ptr %4, align 4
  %8 = load i32, ptr %7, align 4
  %9 = sub nsw i32 %6, %8
  ret i32 %9
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @writeOutput(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca ptr, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %7 = load ptr, ptr %3, align 4
  %8 = call ptr @fopen(ptr noundef %7, ptr noundef @.str.7)
  store ptr %8, ptr %5, align 4
  %9 = load ptr, ptr %5, align 4
  %10 = icmp ne ptr %9, null
  br i1 %10, label %13, label %11

11:                                               ; preds = %2
  %12 = load ptr, ptr %3, align 4
  call void @perror(ptr noundef %12)
  call void @exit(i32 noundef 1) #5
  unreachable

13:                                               ; preds = %2
  store i32 0, ptr %6, align 4
  br label %14

14:                                               ; preds = %29, %13
  %15 = load i32, ptr %6, align 4
  %16 = load ptr, ptr %4, align 4
  %17 = getelementptr inbounds %struct.IntVec, ptr %16, i32 0, i32 1
  %18 = load i32, ptr %17, align 4
  %19 = icmp ult i32 %15, %18
  br i1 %19, label %20, label %32

20:                                               ; preds = %14
  %21 = load ptr, ptr %5, align 4
  %22 = load ptr, ptr %4, align 4
  %23 = getelementptr inbounds %struct.IntVec, ptr %22, i32 0, i32 0
  %24 = load ptr, ptr %23, align 4
  %25 = load i32, ptr %6, align 4
  %26 = getelementptr inbounds i32, ptr %24, i32 %25
  %27 = load i32, ptr %26, align 4
  %28 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %21, ptr noundef @.str.8, i32 noundef %27)
  br label %29

29:                                               ; preds = %20
  %30 = load i32, ptr %6, align 4
  %31 = add i32 %30, 1
  store i32 %31, ptr %6, align 4
  br label %14, !llvm.loop !9

32:                                               ; preds = %14
  %33 = load ptr, ptr %5, align 4
  %34 = call i32 @fclose(ptr noundef %33)
  ret void
}

declare dso_local i32 @printf(ptr noundef, ...) #1

declare dso_local i32 @puts(ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @vecFree(ptr noundef %0) #0 {
  %2 = alloca ptr, align 4
  store ptr %0, ptr %2, align 4
  %3 = load ptr, ptr %2, align 4
  %4 = getelementptr inbounds %struct.IntVec, ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 4
  call void @free(ptr noundef %5)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i32(ptr nocapture writeonly, i8, i32, i1 immarg) #2

declare dso_local ptr @fopen(ptr noundef, ptr noundef) #1

declare dso_local void @perror(ptr noundef) #1

; Function Attrs: noreturn
declare dso_local void @exit(i32 noundef) #3

declare dso_local i32 @fscanf(ptr noundef, ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @isPrime(i32 noundef %0) #0 {
  %2 = alloca i1, align 1
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %5 = load i32, ptr %3, align 4
  %6 = icmp slt i32 %5, 2
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i1 false, ptr %2, align 1
  br label %26

8:                                                ; preds = %1
  store i32 2, ptr %4, align 4
  br label %9

9:                                                ; preds = %22, %8
  %10 = load i32, ptr %4, align 4
  %11 = load i32, ptr %4, align 4
  %12 = mul nsw i32 %10, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp sle i32 %12, %13
  br i1 %14, label %15, label %25

15:                                               ; preds = %9
  %16 = load i32, ptr %3, align 4
  %17 = load i32, ptr %4, align 4
  %18 = srem i32 %16, %17
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %21

20:                                               ; preds = %15
  store i1 false, ptr %2, align 1
  br label %26

21:                                               ; preds = %15
  br label %22

22:                                               ; preds = %21
  %23 = load i32, ptr %4, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %4, align 4
  br label %9, !llvm.loop !10

25:                                               ; preds = %9
  store i1 true, ptr %2, align 1
  br label %26

26:                                               ; preds = %25, %20, %7
  %27 = load i1, ptr %2, align 1
  ret i1 %27
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @vecPush(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 4
  %7 = getelementptr inbounds %struct.IntVec, ptr %6, i32 0, i32 1
  %8 = load i32, ptr %7, align 4
  %9 = load ptr, ptr %3, align 4
  %10 = getelementptr inbounds %struct.IntVec, ptr %9, i32 0, i32 2
  %11 = load i32, ptr %10, align 4
  %12 = icmp eq i32 %8, %11
  br i1 %12, label %13, label %43

13:                                               ; preds = %2
  %14 = load ptr, ptr %3, align 4
  %15 = getelementptr inbounds %struct.IntVec, ptr %14, i32 0, i32 2
  %16 = load i32, ptr %15, align 4
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %23

18:                                               ; preds = %13
  %19 = load ptr, ptr %3, align 4
  %20 = getelementptr inbounds %struct.IntVec, ptr %19, i32 0, i32 2
  %21 = load i32, ptr %20, align 4
  %22 = mul i32 %21, 2
  br label %24

23:                                               ; preds = %13
  br label %24

24:                                               ; preds = %23, %18
  %25 = phi i32 [ %22, %18 ], [ 8, %23 ]
  %26 = load ptr, ptr %3, align 4
  %27 = getelementptr inbounds %struct.IntVec, ptr %26, i32 0, i32 2
  store i32 %25, ptr %27, align 4
  %28 = load ptr, ptr %3, align 4
  %29 = getelementptr inbounds %struct.IntVec, ptr %28, i32 0, i32 0
  %30 = load ptr, ptr %29, align 4
  %31 = load ptr, ptr %3, align 4
  %32 = getelementptr inbounds %struct.IntVec, ptr %31, i32 0, i32 2
  %33 = load i32, ptr %32, align 4
  %34 = mul i32 %33, 4
  %35 = call ptr @realloc(ptr noundef %30, i32 noundef %34) #6
  store ptr %35, ptr %5, align 4
  %36 = load ptr, ptr %5, align 4
  %37 = icmp ne ptr %36, null
  br i1 %37, label %39, label %38

38:                                               ; preds = %24
  call void @perror(ptr noundef @.str.6)
  call void @exit(i32 noundef 1) #5
  unreachable

39:                                               ; preds = %24
  %40 = load ptr, ptr %5, align 4
  %41 = load ptr, ptr %3, align 4
  %42 = getelementptr inbounds %struct.IntVec, ptr %41, i32 0, i32 0
  store ptr %40, ptr %42, align 4
  br label %43

43:                                               ; preds = %39, %2
  %44 = load i32, ptr %4, align 4
  %45 = load ptr, ptr %3, align 4
  %46 = getelementptr inbounds %struct.IntVec, ptr %45, i32 0, i32 0
  %47 = load ptr, ptr %46, align 4
  %48 = load ptr, ptr %3, align 4
  %49 = getelementptr inbounds %struct.IntVec, ptr %48, i32 0, i32 1
  %50 = load i32, ptr %49, align 4
  %51 = add i32 %50, 1
  store i32 %51, ptr %49, align 4
  %52 = getelementptr inbounds i32, ptr %47, i32 %50
  store i32 %44, ptr %52, align 4
  ret void
}

declare dso_local i32 @fclose(ptr noundef) #1

; Function Attrs: allocsize(1)
declare dso_local ptr @realloc(ptr noundef, i32 noundef) #4

declare dso_local i32 @fprintf(ptr noundef, ptr noundef, ...) #1

declare dso_local void @free(ptr noundef) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { allocsize(1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-smaia,-experimental-ssaia,-experimental-zacas,-experimental-zfa,-experimental-zfbfmin,-experimental-zicond,-experimental-zihintntl,-experimental-ztso,-experimental-zvbb,-experimental-zvbc,-experimental-zvfbfmin,-experimental-zvfbfwma,-experimental-zvkg,-experimental-zvkn,-experimental-zvknc,-experimental-zvkned,-experimental-zvkng,-experimental-zvknha,-experimental-zvknhb,-experimental-zvks,-experimental-zvksc,-experimental-zvksed,-experimental-zvksg,-experimental-zvksh,-experimental-zvkt,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xcvbitmanip,-xcvmac,-xsfcie,-xsfvcp,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zicntr,-zicsr,-zifencei,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { noreturn }
attributes #6 = { allocsize(1) }

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
