# Programs and tools that require cross-compilation to function
# These cannot be built on riscv at the moment
self: super: let
  pkgs_x86_64 = import self.path {
    system = "x86_64-linux";
    crossSystem.system = "riscv64-linux";
    overlays = [(import ../cross-overlay.nix)];
  };
in {
  # GHC programs cannot be built riscv64 at the moment, nor can ghc be cross compiled to riscv64
  inherit (pkgs_x86_64) pandoc;
}
