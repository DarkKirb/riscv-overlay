let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    boehmgc
    pandoc
    pixman
    rclone
    ;
}
