self: super: haskellSelf: haskellSuper: {
  # Very expensive testsuite that only runs natively
  happy = self.haskell.lib.dontCheck haskellSuper.happy;
}
