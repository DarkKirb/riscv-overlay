self: super: haskellSelf: haskellSuper: {
  # Disable library profiling because it doesn’t work lol
  mkDerivation =
    args:
    haskellSuper.mkDerivation (
      {
        enableLibraryProfiling = false;
      }
      // args
    );
  # Very expensive testsuite that only runs natively
  happy = self.haskell.lib.dontCheck haskellSuper.happy;
}
