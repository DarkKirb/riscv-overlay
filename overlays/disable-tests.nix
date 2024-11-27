# Tests with inappropriate timeouts
# These time out several times after testing. They would probably still succeed if these limits were removed or increased.
self: super:
let
  mkNoTest =
    name:
    super.${name}.overrideAttrs {
      doCheck = false;
      doInstallCheck = false;
    };
  mkNoTests = map (name: {
    inherit name;
    value = mkNoTest name;
  });
in
{
  xorg = super.xorg.overrideScope (
    _: _: {
      inherit (self) pixman;
    }
  );
  nixVersions = super.nixVersions // {
    latest = super.nixVersions.latest.overrideAttrs {
      doCheck = false;
      doInstallCheck = false;
    };
  };
}
// builtins.listToAttrs (mkNoTests [
  "fish"
  "git"
  "gitMinimal"
  "mdbook"
  "nix"
  "libopus"
  "openexr"
  "openldap"
  "pixman"
  "re2"
  "ripgrep"
  "universal-ctags"
  "wolfssl"
])
