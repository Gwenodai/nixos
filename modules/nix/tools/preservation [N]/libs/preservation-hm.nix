# Create a preservation bridge module for use within Home Manager
{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    config,
    lib,
    ...
  }: {
    # Construct real `preserveAt` output from HM preservation declarations
    preservation.preserveAt = lib.mkMerge (
      lib.flatten (
        lib.mapAttrsToList (username: userConfig:
          lib.mapAttrsToList (persistTarget: persistConfig:
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
      home.preservation.preserveAt = lib.mkOption {
        default = {};
        type = lib.types.attrsOf (lib.types.submodule {
          options = {

            directories = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [];
            };

            files = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [];
            };

            commonMountOptions = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [];
            };
          };
        });
      };
    };
  };
}