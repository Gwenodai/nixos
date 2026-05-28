# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html
{ inputs, den, ... }:
let
  preservation = {
    nixos =
      { config, ... }:
      {
        imports = [ inputs.preservation.nixosModules.preservation ];
        preservation.enable = true;
      };
  };
in
{
  flake-file.inputs.preservation = {
    url = "github:nix-community/preservation";
  };

  den.aspects.persist.includes = [
    preservation
  ];
}
