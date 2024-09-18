self: super: pythonSelf: pythonSuper: {
  hypothesis = pythonSuper.hypothesis.overrideAttrs {
    doInstallCheck = false;
  };
  psutil = pythonSuper.psutil.overrideAttrs (super: {
    requiredSystemFeatures = super.requiredSystemFeatures or [] ++ ["native-riscv"];
  });
  cbor2 = pythonSuper.cbor2.overrideAttrs {
    doInstallCheck = false;
  };
  mypy = pythonSuper.mypy.overrideAttrs {
    env = {};
    doInstallCheck = false;
  };
}
