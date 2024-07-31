self: super: pythonSelf: pythonSuper: {
  hypothesis = pythonSuper.hypothesis.overrideAttrs {
    doInstallCheck = false;
  };
  psutil = pythonSuper.psutil.overrideAttrs (super: {
    requiredSystemFeatures = super.requiredSystemFeatures or [] ++ ["native-riscv"];
  });
}
