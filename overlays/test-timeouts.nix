# Tests with inappropriate timeouts
# These time out several times after testing. They would probably still succeed if these limits were removed or increased.
self: super: {
  xorg = super.xorg.overrideScope (_: _: {
    inherit (self) pixman;
  });
  pixman = super.pixman.overrideAttrs (_: {
    doCheck = false;
  });
}
