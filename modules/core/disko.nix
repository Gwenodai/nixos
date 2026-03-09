# Declarative disk partitioning and formatting using nix
{
  inputs,
  den,
  lib,
  ...
}: {
  # Flake inputs
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.disko.provides = {
    # Create a `disko` class to house disko config
    diskoClass = { host }:
      den.provides.forward {
        each = lib.singleton true;
        fromClass = _: "disko";
        intoClass = _: host.class;
        intoPath = _: []; # top-level
        fromAspect = _: den.aspects.${host.aspect};
      };
    # Import the disko module for NixOS
    diskoImport = { host }: {
      nixos.imports = [ inputs.disko.nixosModules.disko ];
    };
  };

  # Include disko by default in all hosts
  den.ctx.host.includes = with den.aspects.disko.provides; [
    diskoClass
    diskoImport
  ];
}