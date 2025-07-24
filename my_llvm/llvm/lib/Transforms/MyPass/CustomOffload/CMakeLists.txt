add_llvm_library(CustomOffloadPass MODULE
	CustomOffloadPass.cpp

	PLUGIN_TOOL
	opt
)
