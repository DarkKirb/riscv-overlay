# Tests with inappropriate timeouts
# These time out several times after testing. They would probably still succeed if these limits were removed or increased.
self: super: let
  mkNoTest = name:
    super.${name}.overrideAttrs {
      doCheck = false;
      doInstallCheck = false;
    };
  mkNoTests = map (name: {
    inherit name;
    value = mkNoTest name;
  });
in
  {
    llvmPackages_15 =
      super.llvmPackages_15
      // {
        llvm = super.llvmPackages_15.llvm.overrideAttrs {
          doCheck = false;
        };
      };
    llvm_15 = self.llvmPackages_15.llvm;
    llvmPackages_17 =
      super.llvmPackages_17
      // rec {
        libllvm = (super.llvmPackages_17.libllvm.overrideAttrs {
          doCheck = false;
        }).override {
          enableSharedLibraries = true;
        };
        llvm = libllvm;
      };
    llvm_17 = self.llvmPackages_17.llvm;
    llvmPackages_18 =
      super.llvmPackages_18
      // rec {
        libllvm = (super.llvmPackages_18.libllvm.overrideAttrs {
          doCheck = false;
        }).override {
          enableSharedLibraries = true;
        };
        llvm = libllvm;
      };
    llvm_18 = self.llvmPackages_18.llvm;
    xorg = super.xorg.overrideScope (_: _: {
      inherit (self) pixman;
    });
  }
  // builtins.listToAttrs (mkNoTests [
    "openldap"
    "pixman"
    "universal-ctags"
  ])
