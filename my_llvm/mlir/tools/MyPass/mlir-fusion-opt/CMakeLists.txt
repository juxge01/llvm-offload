get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
set(LLVM_LINK_COMPONENTS
  Support
  )

set(LIBS
  ${dialect_libs}
  
  MLIRAffineAnalysis
  MLIRAnalysis
  MLIRCastInterfaces
  MLIRDialect
  MLIRParser
  MLIRPass
  MLIRTransforms
  MLIRTransformUtils
  MLIRSupport
  MLIRIR
  )

include_directories(../../../clang/include)

add_mlir_tool(mlir-fusion-opt
  mlir-fusion-opt.cpp

  SUPPORT_PLUGINS
  )
mlir_target_link_libraries(mlir-fusion-opt PRIVATE ${LIBS})
llvm_update_compile_flags(mlir-fusion-opt)

mlir_check_all_link_libraries(mlir-fusion-opt)
export_executable_symbols_for_plugins(mlir-fusion-opt)
