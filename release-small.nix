{ nixpkgs }:
let
  pkgs = import <nixpkgs> {
    system = "x86_64-linux";
  };

  nixpkgs' =
    with pkgs;
    stdenv.mkDerivation {
      name = "nixpkgs-patched";
      src = pkgs.path;
      dontUnpack = true;
      buildPhase = "";
      installPhase = ''
        cp -r $src $out
        chmod +w -R $out/
        mv $out/default.nix $out/default2.nix
        cp ${writeText "default.nix" ''
          {overlays ? [], ...} @ args: import ./default2.nix (args // {overlays = overlays ++ [(import ${./.}/default.nix)]; })
        ''} $out/default.nix
      '';
    };
in
with pkgs.lib;
import "${nixpkgs}/nixos/release-small.nix" {
  supportedSystems = [ "riscv64-linux" ];
  nixpkgs = {
    outPath = cleanSource nixpkgs';
    revCount = 56789;
    shortRev = "gfedcba";
  };
}
