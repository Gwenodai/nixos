# Creates a custom Preservation module for use within Home Manager
{
  flake.modules.nixos.preservation = {
    config,
    lib,
    ...
  }: {
    config = {
      home-manager.sharedModules = [
        # Allows for use of `lib.mkIf config.preservation.enable` from within HM modules
        { preservation.enable = config.preservation.enable; }
      ];

      # Construct real `preserveAt` output from all HM preservation declarations
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
  };

  flake.modules.homeManager.preservation = {
    lib,
    ...
  }: {
    # Define options available for use within Home Manager
    options = {
      preservation.enable = lib.mkEnableOption "preservation (propagated from NixOS)";

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