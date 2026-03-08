# Declarative home management
{
  lib,
  ...
}: {
  # Flake inputs
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Default home manager settings
  den.ctx.hm-host = {
    nixos.home-manager = {
      useUserPackages = lib.mkDefault true;
      useGlobalPkgs = lib.mkDefault true;
      backupFileExtension = lib.mkDefault "backup";
      overwriteBackup = lib.mkDefault true;
    };
  };
  den.ctx.user = {
    homeManager.home.stateVersion = lib.mkDefault "25.11";
  };
}