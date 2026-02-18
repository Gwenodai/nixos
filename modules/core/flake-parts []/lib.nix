# Helper functions for creating system configurations
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
  };
}