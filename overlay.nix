with (import ./lib.nix);
composeManyExtensions [
  (import ./overlays/disable-tests.nix)
  (import ./overlays/ghc.nix)
  (import ./overlays/misc.nix)
  (import ./overlays/patches)
  (import ./overlays/python.nix)
]
