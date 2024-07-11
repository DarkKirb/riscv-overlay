# Tests with inappropriate timeouts
# These time out several times after testing. They would probably still succeed if these limits were removed or increased.
self: super: {
  xorg = super.xorg.overrideScope (_: _: {
    inherit (self) pixman;
  });
  pixman = super.pixman.overrideAttrs (_: {
    doCheck = false;
  });
  llvmPackages_15 =
    super.llvmPackages_15
    // {
      llvm = super.llvmPackages_15.llvm.overrideAttrs {
        doCheck = false;
      };
    };
  llvm_15 = self.llvmPackages_15.llvm;
  openldap = super.openldap.overrideAttrs {
    doCheck = false;
  };
}
