# Tell Tablegen to use MyExtension.td as input.
set(LLVM_TARGET_DEFINITIONS MyExtension.td)

# Ask Tablegen to generate op declarations and definitions from ODS.
mlir_tablegen(MyExtension.h.inc -gen-op-decls)
mlir_tablegen(MyExtension.cpp.inc -gen-op-defs)

# Add a CMakeTarget we can depend on to ensure the generation happens before the compilation.
add_public_tablegen_target(MyExtensionAcceleratorIncGen)

# Don't forget to generate the documentation, this will produce a
# MyExtensionAccelerator.md under Tutorials/transform
add_mlir_doc(MyExtension MyExtensionAccelerator Tutorials/transform/ -gen-op-doc)
