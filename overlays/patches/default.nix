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
      sha256 = "sha256-zgTeMpAzIb05Dv9ey7ER075218MkI+ZmT3nYpNCdS+w=";
    };
    meta =
      super.meta
      // {
        badPlatforms = ["powerpc64le-linux"];
      };
  });
  luajitPackages = self.luajit.pkgs;
  luajit_2_1 = self.luajit;
}
