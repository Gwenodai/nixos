# Storage for factory aspect functions
{
  lib,
  ...
}: {
  options.flake.factory = with lib; mkOption {
    type = with types; attrsOf unspecified;
    default = { };
  };
}
