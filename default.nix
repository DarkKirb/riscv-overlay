let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    boehmgc
    ghc
    pixman
    rclone
    ;
}
