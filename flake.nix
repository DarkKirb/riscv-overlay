{
  description = "riscv overlay";

  outputs = {
    self,
    nixpkgs,
  }: {
    overlays.default = import ./overlay.nix;
    overlays.crossCompile = import ./cross-overlay.nix;
  };
}
