# Imports Disko for NixOS
{
  inputs,
  den,
  ...
}: {
  den.ctx.host.includes = [ den.aspects.disko ];
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.disko = den.lib.take.exactly (
    { host }: let
      diskoClass = "disko";
      diskoModule = let
        aspect = den.ctx.host { inherit host; };
      in
      aspect.resolve { class = diskoClass; };
    in {
      description = ''
        integrates disko into nixos OS classes.

        usage:

          for aspects accessing disko in just a particular host:

          den.aspects.my-host.includes = [ den.aspects.disko ];

          for aspects enabling disko by default on all hosts:

          den.ctx.host.includes = [ den.aspects.disko ];

        Does nothing for hosts that have no aspects with `{diskoClass}` class.
        Expects `inputs.disko` to exist.

        For each host resolves den.aspects.{host.aspect} and imports its disko class module.
      '';

      nixos.imports = [
        inputs.disko."${host.class}Modules".disko
        diskoModule
      ];
    }
  );
}