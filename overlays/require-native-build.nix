self: super: let
  mkNativeBuild = name:
    super.${name}.overrideAttrs (super: {
      requiredSystemFeatures = super.requiredSystemFeatures or [] ++ ["native-riscv"];
    });
  mkNativeBuilds = map (name: {
    inherit name;
    value = mkNativeBuild name;
  });
in
  builtins.listToAttrs (mkNativeBuilds [
    "boehmgc"
    "libuv"
    "rclone"
  ])
