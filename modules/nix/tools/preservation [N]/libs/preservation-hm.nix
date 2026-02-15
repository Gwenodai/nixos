# Create a preservation bridge module for use within Home Manager
{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    config,
    lib,
    ...
  }: {
    # Construct real `preserveAt` output from HM preservation declarations
    preservation.preserveAt = with lib; mkMerge (
      flatten (
        mapAttrsToList (username: userConfig:
          mapAttrsToList (persistTarget: persistConfig:
            {
              "${persistTarget}" = {
                users."${username}" = {
                  directories = persistConfig.directories;
                  files = persistConfig.files;
                  commonMountOptions = persistConfig.commonMountOptions;
                };
              };
            }
          ) userConfig.home.preservation.preserveAt # = `persistTarget`.`persistConfig`
        ) config.home-manager.users # = `username`.`userConfig`
      )
    );
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.preservation = {
    lib,
    ...
  }: {
    # Define custom Preservation options for use within Home Manager
    options = {
      home.preservation.preserveAt = with lib; mkOption {
        default = {};
        type = with types; attrsOf (submodule {
          options = {

            directories = mkOption {
              type = listOf anything;
              default = [];
            };

            files = mkOption {
              type = listOf anything;
              default = [];
            };

            commonMountOptions = mkOption {
              type = listOf str;
              default = [];
            };
          };
        });
      };
    };
  };
}