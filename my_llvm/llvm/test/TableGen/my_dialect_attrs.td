// my_dialect_attrs.td
// mlir-tblgen --gen-attrdef ..
dump "My Custom Dialect !";

def OffloadAccelAttr : StrEnumAttr<
  "offload.accel",
  [ "vtop" ]  
>;
