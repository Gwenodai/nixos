# Declarative disk partitioning and formatting using nix
{ inputs, den, lib, ... }: {
  # Flake inputs
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.disko = {
    # Create a `disko` class to house disko config
    provides.diskoClass = { host }: den.provides.forward {
        each = lib.singleton true;
        fromClass = _: "disko";
        intoClass = _: "nixos"; # Disko only supports NixOS
        intoPath = _: [ "disko" ];
        fromAspect = _: den.aspects.${host.aspect};
        guard = { options, ... }@osArgs: options ? disko;
      };
    # Import the disko module for NixOS
    provides.diskoImport = { host }: {
      nixos.imports = [ inputs.disko.nixosModules.disko ];
    };
  };

  # Include disko by default in all hosts
  den.ctx.host.includes = with den.aspects.disko.provides; [
    diskoImport
    diskoClass
  ];
}