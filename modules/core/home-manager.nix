# Declarative home management
{ den, lib, ... }: {
  # Flake inputs
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.home-manager = {
    provides.nixConfig = den.lib.take.exactly ({ host }: {
      nixos.home-manager = {
        useUserPackages = lib.mkDefault true;
        useGlobalPkgs = lib.mkDefault true;
        backupFileExtension = lib.mkDefault "backup";
        overwriteBackup = lib.mkDefault true;
      };
    });

    provides.hmConfig = { user, ... }: {
      homeManager.home.stateVersion = lib.mkDefault "25.11";
    };
  };

  # Default home manager settings
  den.ctx.hm-host = {
    includes = [ den.aspects.home-manager.provides.nixConfig ];
  };
  den.ctx.hm-user = {
    includes = [ den.aspects.home-manager.provides.hmConfig ];
  };
}