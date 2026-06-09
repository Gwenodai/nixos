# Helper functions made using flake-parts
{ den, lib, ... }:
{
  options.flake.lib = lib.mkOption {
    type = with lib.types; attrsOf unspecified;
    default = { };
  };

  config.flake.lib =
    let
      # Finds a host included aspect via its name prefix
      getActiveAspectByPrefix =
        {
          host,
          prefix,
        }:
        let
          activeAspectsList = lib.attrNames (
            lib.filterAttrs (name: aspect: host.hasAspect aspect) den.aspects
          );
          targetAspect = lib.head (lib.filter (name: lib.hasPrefix prefix name) activeAspectsList);
        in
        targetAspect;
    in
    {
      inherit getActiveAspectByPrefix;

      # Finds a host included aspects bin path via its name prefix
      getActiveAspectBinByPrefix =
        {
          host,
          pkgs,
          prefix,
        }:
        let
          aspect = getActiveAspectByPrefix { inherit host prefix; };
        in
        den.aspects.${aspect}.meta.binPath pkgs;

      # Function to wrap every value directly under an attrute in `lib.mkDefault`
      applyDefaults = lib.mapAttrs (_: value: lib.mkDefault value);

      # Function to wrap every final value in `lib.mkDefault`
      # ONLY USE THIS FOR PURE DATA FILES (i.e., `programs.niri.settings` from niri-flake)
      applyDefaultsRecursive = lib.mapAttrsRecursive (_: value: lib.mkDefault value);
    };
}
