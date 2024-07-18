let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    boehmgc
    elfutils
    fish
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
    openldap
    pixman
    rclone
    ripgrep
    systemd
    universal-ctags
    wolfssl
    ;
  haskell = {
    compiler = {
      inherit (pkgs.haskell.compiler) ghc948Boot ghc965 ghc96;
    };
    packages = let
      mkHaskellPackages = version: {
        inherit (pkgs.haskell.packages.${version}) happy;
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
    inherit (pkgs.python3Packages) hypothesis;
  };
  python312Packages = {
    inherit (pkgs.python312Packages) hypothesis;
  };
}
