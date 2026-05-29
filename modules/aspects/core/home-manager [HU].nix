# Declarative home management
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.home-manager = {
    hostConfig = {
      nixos.home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";
        overwriteBackup = true;
      };
    };

    userConfig = {
      homeManager.home.stateVersion = "25.11";
    };
  };
}
