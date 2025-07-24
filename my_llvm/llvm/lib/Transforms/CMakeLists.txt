add_subdirectory(Utils)
add_subdirectory(Instrumentation)
add_subdirectory(AggressiveInstCombine)
add_subdirectory(InstCombine)
add_subdirectory(Scalar)
add_subdirectory(IPO)
add_subdirectory(Vectorize)
add_subdirectory(ObjCARC)
add_subdirectory(Coroutines)
add_subdirectory(CFGuard)
add_subdirectory(HipStdPar)
add_subdirectory(Hello)

## MyPass
add_subdirectory(MyPass/FuncName)
add_subdirectory(MyPass/CountInst)
add_subdirectory(MyPass/MemAccess)
add_subdirectory(MyPass/AutoOffload)
add_subdirectory(MyPass/CustomOffload)
add_subdirectory(MyPass/SwitchCase)
## MLIR
## Demo
add_subdirectory(Demo)
