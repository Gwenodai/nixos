# Helper function for creating system configurations
{
  inputs,
  lib,
  ...
}: {
  options.flake.lib = lib.mkOption {
    type = with lib.types; attrsOf unspecified;
    default = { };
  };

  config.flake.lib = {
    # For creating NixOS configurations
    mkNixos = system: name: {
      "${name}" = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ];
      };
    };

    # Function to wrap every value directly under an attrute in `lib.mkDefault`
    applyDefaults          = lib.mapAttrs (option: value: lib.mkDefault value);
    # Function to wrap every final value in `lib.mkDefault`
    # ONLY USE THIS FOR PURE DATA FILES (i.e., `programs.niri.settings` from niri-flake)
    applyDefaultsRecursive = lib.mapAttrsRecursive (option: value: lib.mkDefault value);
  };
}