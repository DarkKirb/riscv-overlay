self: super: {
  gn = super.gn.overrideAttrs (super: {
    patches =
      super.patches
      or []
      ++ [
        ./gn/fix-build-for-riscv-arch.patch
      ];
  });
}
