# Declarative home management
{ den, lib, ... }: {
  # Flake inputs
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Default home manager settings
  den.ctx.hm-host.includes = [ den.aspects.home-manager._.nixConfig ];
  den.ctx.hm-user.includes = [ den.aspects.home-manager._.hmConfig ];

  den.aspects.home-manager = {
    _.nixConfig = den.lib.perHost {
      nixos.home-manager = {
        useUserPackages = lib.mkDefault true;
        useGlobalPkgs = lib.mkDefault true;
        backupFileExtension = lib.mkDefault "backup";
        overwriteBackup = lib.mkDefault true;
      };
    };

    _.hmConfig = {
      homeManager.home.stateVersion = lib.mkDefault "25.11";
    };
  };
}