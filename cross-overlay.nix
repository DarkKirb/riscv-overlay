self: super: let
  ghc_cross_nixpkgs = self.fetchFromGitHub {
    owner = "sternenseemann";
    repo = "nixpkgs";
    rev = "75cab635d61262a3394219fad3eca98bed78e8d1";
    sha256 = "1mss2qcysi52ih0q3lbisxi66r5dnszlz9algvzrapf2i7valfwi";
  };
  ghc_cross_pkgs = import ghc_cross_nixpkgs {
    system = "x86_64-linux";
    crossSystem.system = "riscv64-linux";
  };
in {
  ghcRiscvBoot = self.linkFarm "ghc-boot" {
    "ghc-9.4.8" = ghc_cross_pkgs.haskell.compiler.native-bignum.ghc948;
  };
}
