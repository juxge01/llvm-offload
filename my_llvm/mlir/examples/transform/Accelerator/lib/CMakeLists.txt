# Outside examples, this should be `add_mlir_library`.
add_mlir_example_library(
  # Library called MyExtension.
  MyExtensionAccelerator

  # Built from the following source files.
  MyExtension.cpp

  # Make includes visible without top-level path.
  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/examples/transform/Accelerator/include

  # Make sure ODS declaration and definitions are generated before compiling this.
  DEPENDS
  MyExtensionAcceleratorIncGen

  # Link in the transform dialect, an all generated dialects.
  LINK_LIBS PRIVATE
  MLIRTransformDialect
  MLIRFuncDialect
  MLIRSCFDialect
)
