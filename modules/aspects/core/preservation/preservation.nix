# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html
{ inputs, ... }:
{
  flake-file.inputs.preservation.url = "github:nix-community/preservation";

  den.aspects.preservation = {
    nixos =
      { config, ... }:
      {
        imports = [ inputs.preservation.nixosModules.preservation ];
        # Globally enable Preservation by default if this aspect is included
        preservation.enable = true;
      };
  };
}
