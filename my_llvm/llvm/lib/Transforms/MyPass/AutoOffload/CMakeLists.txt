add_llvm_library(AutoOffloadPass MODULE
	AutoOffloadPass.cpp

	PLUGIN_TOOL
	opt
)
