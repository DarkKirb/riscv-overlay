# The mess that is overriding LLVM
self: super: let
  mkLlvm = {dynamic ? false}: llvmSelf: llvmSuper:
    llvmSuper
    // (let
      clangVersion = super.lib.versions.major llvmSuper.clang.version;
      mkExtraBuildCommands0 = cc: ''
        rsrc="$out/resource-root"
        mkdir "$rsrc"
        ln -s "${cc.lib}/lib/clang/${clangVersion}/include" "$rsrc"
        echo "-resource-dir=$rsrc" >> $out/nix-support/cc-cflags
      '';
      mkExtraBuildCommands = cc:
        mkExtraBuildCommands0 cc
        + ''
          ln -s "${llvmSelf.compiler-rt.out}/lib" "$rsrc/lib"
          ln -s "${llvmSelf.compiler-rt.out}/share" "$rsrc/share"
        '';
    in {
      libllvm =
        if dynamic
        then
          (llvmSuper.libllvm.overrideAttrs {
            doCheck = false;
          })
          .override {
            enableSharedLibraries = true;
          }
        else
          llvmSuper.libllvm.overrideAttrs {
            doCheck = false;
          };
      llvm =
        if dynamic
        then llvmSelf.libllvm
        else
          llvmSuper.llvm.overrideAttrs {
            doCheck = false;
          };
      compiler-rt-libc = llvmSuper.compiler-rt-libc.override {
        inherit (llvmSelf) libllvm;
      };
      compiler-rt = llvmSelf.compiler-rt-libc;
      libclang = llvmSuper.libclang.override {
        inherit (llvmSelf) libllvm;
        patches = [
          ./patches/clang/purity.patch
          ./patches/clang/gnu-install-dirs.patch
          ./patches/clang/add-nostdlibinc-flag.patch
          (self.substituteAll {
            src = ./clang/llvmgold-path.patch;
            libllvmLibdir = "${llvmSelf.libllvm.lib}/lib";
          })
        ];
      };
      clang-unwrapped = llvmSelf.libclang;
      libstdcxxClang = self.wrapCCWith rec {
        cc = llvmSelf.clang-unwrapped;
        libcxx = null;
        extraPackages = [
          llvmSelf.compiler-rt
        ];
        extraBuildCommands = mkExtraBuildCommands cc;
      };
      clang = llvmSelf.libstdcxxClang;
      stdenv = self.overrideCC self.stdenv llvmSelf.clang;
    });
in {
  llvmPackages_15 = mkLlvm {} self.llvmPackages_15 super.llvmPackages_15;
  llvm_15 = self.llvmPackages_15.llvm;
  llvmPackages_17 = mkLlvm {dynamic = true;} self.llvmPackages_17 super.llvmPackages_17;
  llvm_17 = self.llvmPackages_17.llvm;
  clang_17 = self.llvmPackages_17.clang;
  clang = self.clang_17;
  llvm = self.llvm_17;
  llvmPackages_18 = mkLlvm {} self.llvmPackages_18 super.llvmPackages_18;
  llvm_18 = self.llvmPackages_18.llvm;
}
