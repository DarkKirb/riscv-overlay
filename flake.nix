{
  description = "riscv overlay";

  outputs = {
    self,
    nixpkgs,
  }: {
    overlays.default = import ./overlay.nix;
    overlays.crossCompile = import ./cross-overlay.nix;
    packages.riscv64-linux = let
      pkgs = import nixpkgs {
        system = "riscv64-linux";
        overlays = [self.overlays.default];
      };
    in {
      inherit
        (pkgs)
        pandoc
        pixman
        rclone
        ;
    };
  };
}
