self: super: let
  pkgs_x86_64 = import self.path {
    system = "x86_64-linux";
    crossSystem.system = "riscv64-linux";
    overlays = [(import ./cross-overlay.nix)];
  };
in {
  inherit (pkgs_x86_64) pandoc;
}
