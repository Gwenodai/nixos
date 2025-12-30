{
  inputs,
  lib,
  ...
}:

{
  # Helper functions for creating system / home-manager configurations

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
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

    # For creating standalone Home-Manager configurations for non-NixOS
    mkHomeManager = system: name: {
      "${name}" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          inputs.self.modules.homeManager.${name}
        ];
      };
    };
  };
}