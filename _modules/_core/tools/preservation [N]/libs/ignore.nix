# Define options for declaring files to be ignored by `find-ephemeral`
{
  lib,
  ...
}: let
  sharedOptions = {
    host.preservation.ignore = lib.mkOption {
      default = {};
      type = with lib.types; submodule {
        options = {
          directories = lib.mkOption {
            type = listOf str;
            default = [];
          };
          files = lib.mkOption {
            type = listOf str;
            default = [];
          };
        };
      };
    };
  };
  in {
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    config,
    lib,
    ...
  }: {
    options = sharedOptions;

    config = let
      getHmPaths = keyName: lib.concatLists (
        lib.mapAttrsToList (username: userConfig:
          let
            homeDir = userConfig.home.homeDirectory;
            ignorePaths = userConfig.host.preservation.ignore."${keyName}" or [];
          in
          map (path: 
            # If the path is already absolute, keep it. Otherwise, prepend home dir.
            if lib.hasPrefix "/" path then
              path 
            else
              "${homeDir}/${path}"
          ) ignorePaths
        ) (config.home-manager.users or {})
      );
    in {
      # Merge the compiled Home Manager lists into the NixOS level options
      host.preservation.ignore = {
        directories = getHmPaths "directories";
        files       = getHmPaths "files";
      };
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.preservation = {
    ...
  }: {
    options = sharedOptions;
  };
}