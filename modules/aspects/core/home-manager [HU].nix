# Declarative home management
{ den, ... }:
let
  hostConfig = den.lib.perHost {
    nixos.home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";
      overwriteBackup = true;
    };
  };

  userConfig = den.lib.perUser {
    homeManager.home.stateVersion = "25.11";
  };
in
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.home-manager.includes = [
    hostConfig
    userConfig
  ];
}
