// RUN: mlir-opt simple.mlir | mlir-custom-pass --auto-offload --dump-arith --offload-threshold=1 | FileCheck simple.mlir -check-prefix=OFFLOAD 
// RUN: mlir-opt simple.mlir | mlir-custom-pass --auto-offload --offload-threshold=1 | FileCheck simple.mlir -check-prefix=ARITH 

func.func @kernel(%a: tensor<i32>) -> tensor<i32> {
  %0 = arith.addi %a, %a : tensor<i32>
  return %0 : tensor<i32>
  // ARITH: func.func @kernel{{.*}} attributes { offload.target = "custom-accel" }
  // OFFLOAD: [dump] kernel : 1
}
