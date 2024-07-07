let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    boehmgc
    ghc
    libuv
    pixman
    rclone
    ;
}
