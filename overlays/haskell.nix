self: super: haskellSelf: haskellSuper: {
  # Very expensive testsuite that only runs natively
  happy = self.haskell.lib.dontCheck haskellSuper.happy;
  # Requires profiling libs for ghc?
  hscolour = self.haskell.lib.disableLibraryProfiling haskellSuper.hscolour;
}
