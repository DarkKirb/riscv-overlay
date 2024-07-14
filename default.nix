let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    boehmgc
    libuv
    libseccomp
    llvm
    llvm_15
    llvm_17
    llvm_18
    openldap
    pixman
    rclone
    systemd
    universal-ctags
    ;
  haskell = {
    compiler = {
      inherit (pkgs.haskell.compiler) ghc948Boot ghc965 ghc96;
    };
    packages = let
      mkHaskellPackages = version: {
        inherit (pkgs.haskell.packages.${version}) happy;
      };
    in (builtins.listToAttrs (map (version: {
        name = version;
        value = mkHaskellPackages version;
      }) [
        "ghc965"
        "ghc96"
      ]));
  };
  python3Packages = {
    inherit (pkgs.python3Packages) hypothesis;
  };
  python312Packages = {
    inherit (pkgs.python312Packages) hypothesis;
  };
}
