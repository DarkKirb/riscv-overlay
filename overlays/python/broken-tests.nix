self: super: pythonSelf: pythonSuper: {
  hypothesis = pythonSuper.hypothesis.overrideAttrs {
    doInstallCheck = false;
  };
}
