{
  description = "riscv overlay";

  outputs =
    {
      self,
      nixpkgs,
    }:
    {
      overlays.default = import ./overlay.nix;
      overlays.crossCompile = import ./cross-overlay.nix;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
