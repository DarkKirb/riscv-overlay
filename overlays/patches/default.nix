self: super: {
  gn = super.gn.overrideAttrs (super: {
    patches =
      super.patches
      or []
      ++ [
        ./gn/fix-build-for-riscv-arch.patch
      ];
  });
  luajit = super.luajit.overrideAttrs (super: {
    src = self.fetchFromGitHub {
      owner = "plctlab";
      repo = "LuaJIT";
      rev = "1893cf72c264f837596614a537a18e83b8c1b678";
      sha256 = "0vchl5pjwyj8jsxibx2rbzk5gcbdzd3gwl62fy3sazp8ilxxihnj";
    };
    meta =
      super.meta
      // {
        badPlatforms = ["powerpc64le-linux"];
      };
  });
}
