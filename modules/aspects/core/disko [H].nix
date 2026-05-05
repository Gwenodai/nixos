# Declarative disk partitioning and formatting using nix
{ inputs, den, ... }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.disko = den.lib.perHost {
    nixos.imports = [ inputs.disko.nixosModules.disko ];
  };
}
