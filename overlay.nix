with (import ./lib.nix);
  composeManyExtensions [
    (import ./overlays/disable-tests.nix)
    (import ./overlays/ghc.nix)
    (import ./overlays/misc.nix)
    (import ./overlays/python.nix)
    (import ./overlays/require-native-build.nix)
  ]
