// opt -load-pass-plugin=CustomOffloadPass.so \
//        -passes='function(mem-access)' -disable-output test.ll

#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/IntrinsicsRISCV.h"

#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

namespace {

struct CustomOffloadPass : public PassInfoMixin<CustomOffloadPass> {
  static bool isRequired() { return true; }

  PreservedAnalyses run(Module &M, ModuleAnalysisManager &) {
    LLVMContext &Ctx = M.getContext();
    Type *I32Ty      = Type::getInt32Ty(Ctx);

    // 1) 함수 단위 루프
    for (Function &F : M) {
      if (F.isDeclaration())
        continue;

      bool HasOffload = false;

      // 2) 기본블록·명령어 순회
      for (auto &BB : F)
        for (auto It = BB.begin(), E = BB.end(); It != E; ) {
          Instruction *I = &*It++;
          auto *BO       = dyn_cast<BinaryOperator>(I);
          if (!BO || BO->getType() != I32Ty)
            continue;                        

          // 3) intrinsic 선언
          Function *C3 =
              Intrinsic::getDeclaration(&M, Intrinsic::riscv_custom3);

          IRBuilder<> B(BO);
          Value *Call = B.CreateCall(C3,
                                     {BO->getOperand(0), BO->getOperand(1)});
          Call->setName("custom3");

          BO->replaceAllUsesWith(Call);
          BO->eraseFromParent();
          HasOffload = true;
        }

      // 4) 함수 attribute 기록(통계·디버그용)
      if (HasOffload)
        F.addFnAttr("offload.target", "custom-accel");
    }

    // IR 을 바꿨으므로 분석 무효화
    return PreservedAnalyses::none();
  }
};

} // end anonymous namespace


extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "CustomOffloadPass", LLVM_VERSION_STRING,
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, ModulePassManager &MPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "custom-offload") {
            MPM.addPass(CustomOffloadPass());
            return true;
          }
          return false;
        });
    }
  };
}
