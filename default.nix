let
  pkgs = import ./pkgs.nix {};
in {
  inherit
    (pkgs)
    pandoc
    pixman
    rclone
    ;
}
