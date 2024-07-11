with (import ./lib.nix);
  composeManyExtensions [
    (import ./overlays/ghc.nix)
    (import ./overlays/python.nix)
    (import ./overlays/require-native-build.nix)
    (import ./overlays/test-timeouts.nix)
  ]
