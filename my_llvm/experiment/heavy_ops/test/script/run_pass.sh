#!/usr/bin/env bash
set -e
SRC=$1           # e.g. mlir/fused.mlir
MODE=$2          # plain | fused

LLVM_BUILD=/home/jueun/park/IREE/llvm-project/mlir-build
LLVM_PASS=$LLVM_BUILD/lib/CustomOffloadPass.so

OUT=build/$MODE
mkdir -p $OUT
# 3‑1) MLIR→LLVM IR
mlir-opt  \
         --time-passes \
         $SRC \
| mlir-translate --mlir-to-llvmir -o $OUT/kernel.ll


# 3‑2) ▼▼ 패스 토글 ▼▼
if [ "$MODE" = "fused" ]; then
  $LLVM_BUILD/bin/opt -load-pass-plugin=$LLVM_PASS -p="custom-offload" $OUT/kernel.ll -o $OUT/kernel_custom.ll
  LLVM_IR=$OUT/kernel_custom.ll
else
  LLVM_IR=$OUT/kernel.ll     # pass 안 탄 베이스라인
fi

# 3‑3) LLVM IR → OBJ
llc -march=riscv32 $LLVM_IR -o $OUT/kernel.o

# 3‑4) 링크
riscv32-unknown-elf-clang --target=riscv32-unknown-elf -O2 -c runtime/main.c -o $OUT/main.o

riscv32-unknown-elf-gcc $OUT/main.o $OUT/kernel.o -lm -o $OUT/app.elf
