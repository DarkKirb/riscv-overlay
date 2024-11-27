args:
import <nixpkgs> (
  args
  // {
    system = "riscv64-linux";
    overlays = [ (import ./overlay.nix) ];
  }
)
