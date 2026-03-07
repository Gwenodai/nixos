# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html
{
  inputs,
  ...
}: {

  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  den.default.nixos.imports = [
    inputs.disko.nixosModules.disko
  ];
}