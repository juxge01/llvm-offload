add_subdirectory(mlir-lsp-server)
add_subdirectory(mlir-opt)
add_subdirectory(mlir-parser-fuzzer)
add_subdirectory(mlir-pdll-lsp-server)
add_subdirectory(mlir-query)
add_subdirectory(mlir-reduce)
add_subdirectory(mlir-rewrite)
add_subdirectory(mlir-shlib)
add_subdirectory(mlir-translate)
add_subdirectory(tblgen-lsp-server)
add_subdirectory(tblgen-to-irdl)

## TODO
add_subdirectory(MyPass/mlir-custom-pass)
add_subdirectory(MyPass/mlir-bottleneck)

# mlir-runner requires ExecutionEngine.
if(MLIR_ENABLE_EXECUTION_ENGINE)
  add_subdirectory(mlir-runner)
endif()
