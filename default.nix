let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    boehmgc
    elfutils
    fish
    git
    gitMinimal
    gn
    libopus
    libuv
    libseccomp
    llvm
    llvm_15
    llvm_17
    llvm_18
    mdbook
    nix
    openexr
    openldap
    pixman
    rclone
    re2
    ripgrep
    systemd
    universal-ctags
    wolfssl
    zeromq
    ;
  nixVersions = {
    inherit (pkgs.nixVersions) latest;
  };
  haskell = {
    compiler = {
      inherit (pkgs.haskell.compiler) ghc948Boot ghc965 ghc96;
    };
    packages = let
      mkHaskellPackages = version: {
        inherit (pkgs.haskell.packages.${version}) happy hscolour;
      };
    in
      (builtins.listToAttrs (map (version: {
          name = version;
          value = mkHaskellPackages version;
        }) [
          "ghc965"
          "ghc96"
        ]))
      // {
        ghc948Boot = {
          inherit (pkgs.haskell.packages.ghc948Boot) alex data-array-byte doctest extra hashable optparse-applicative QuickCheck temporary unordered-containers vector;
        };
      };
  };
  python3Packages = {
    inherit (pkgs.python3Packages) hypothesis psutil cbor2 mypy;
  };
  python312Packages = {
    inherit (pkgs.python312Packages) hypothesis psutil cbor2 mypy;
  };
  llvmPackages_17 = {
    inherit
      (pkgs.llvmPackages_17)
      compiler-rt-libc
      compiler-rt
      libclang
      clang-unwrapped
      libstdcxxClang
      clang
      stdenv
      ;
  };
  llvmPackages_18 = {
    inherit
      (pkgs.llvmPackages_18)
      compiler-rt-libc
      compiler-rt
      libclang
      clang-unwrapped
      libstdcxxClang
      clang
      stdenv
      ;
  };
}
