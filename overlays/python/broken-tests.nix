self: super: pythonSelf: pythonSuper: {
  cbor2 = pythonSuper.cbor2.overrideAttrs {
    doInstallCheck = false;
  };
  dbus-python = pythonSuper.dbus-python.overrideAttrs {
    doInstallCheck = false;
  };
  hypothesis = pythonSuper.hypothesis.overrideAttrs {
    doInstallCheck = false;
  };
  mypy = pythonSuper.mypy.overrideAttrs {
    env = { };
    doInstallCheck = false;
  };
  psutil = pythonSuper.psutil.overrideAttrs (super: {
    requiredSystemFeatures = super.requiredSystemFeatures or [ ] ++ [ "native-riscv" ];
  });
}
