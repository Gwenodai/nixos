# Storage for factory aspect functions
{
  lib,
  ...
}: {
  options.flake.factory = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };
}
