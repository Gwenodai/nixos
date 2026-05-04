# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html

# This aspect should be imported into any host that wants ephemeral storage
# Like so: `den.aspects.<host>.includes = [ den.aspects.persist ];`
{ inputs, den, ... }:
{
  # Flake inputs
  flake-file.inputs.preservation = {
    url = "github:nix-community/preservation";
  };

  den.aspects.persist._.enable = den.lib.perHost {
    nixos =
      { config, lib, ... }:
      {
        # Import the preservation module
        imports = [ inputs.preservation.nixosModules.preservation ];
        # Enable the preservation module by default
        preservation.enable = lib.mkDefault true;
      };
  };
}
