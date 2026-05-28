# Declarative home management
let
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
in
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Apply default home-manager settings to hosts and users
  den.schema.user.includes = [ userConfig ];
  den.schema.hm-host.includes = [ hostConfig ];
}
