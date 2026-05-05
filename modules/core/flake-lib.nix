# Helper functions made using flake-parts
{ lib, ... }:
{
  options.flake.lib = lib.mkOption {
    type = with lib.types; attrsOf unspecified;
    default = { };
  };

  config.flake.lib = {
    # Function to wrap every value directly under an attrute in `lib.mkDefault`
    applyDefaults = lib.mapAttrs (_: value: lib.mkDefault value);

    # Function to wrap every final value in `lib.mkDefault`
    # ONLY USE THIS FOR PURE DATA FILES (i.e., `programs.niri.settings` from niri-flake)
    applyDefaultsRecursive = lib.mapAttrsRecursive (_: value: lib.mkDefault value);
  };
}
