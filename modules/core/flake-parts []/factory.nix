# Storage for factory aspect functions
{
  lib,
  ...
}: {
  options.flake.factory = lib.mkOption {
    type = with lib.types; attrsOf unspecified;
    default = { };
  };
}