self: super: let
  overlay = with (import ../lib.nix);
    composeManyExtensions [
      (import ./python/broken-tests.nix self super)
    ];
in {
  python3 = prev.python3.override {
    packageOverrides = overlay;
  };
  python3Packages = self.python3.pkgs;
  python312 = prev.python.override {
    packageOverrides = overlay;
  };
  python312Packages = self.python312.pkgs;
}
