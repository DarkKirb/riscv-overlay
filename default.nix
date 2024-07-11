let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    boehmgc
    libuv
    libseccomp
    llvm_15
    pixman
    rclone
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
