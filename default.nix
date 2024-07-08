let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    boehmgc
    ghc
    libuv
    llvm_15
    pixman
    rclone
    ;
}
