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
      lib.concatLists (
        lib.mapAttrsToList (username: userConfig:
          let
            homePrefix = "${userConfig.home.homeDirectory}/";
            # Convert any absolute paths back to relative paths
            stripHomePrefix = keyName: list: 
              map (item: item // { 
                "${keyName}" = lib.removePrefix homePrefix item."${keyName}"; 
              }) list;

            preserveConfigs = userConfig.host.preservation.preserveAt or {};
          in
          lib.mapAttrsToList (preserveAtPath: persistConfig: {
            "${preserveAtPath}".users."${username}" = {
              directories        = stripHomePrefix "directory" persistConfig.directories;
              files              = stripHomePrefix "file"      persistConfig.files;
              commonMountOptions = persistConfig.commonMountOptions;
            };
          }) preserveConfigs
        ) (config.home-manager.users or {})
      )
    );
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.preservation = {
    lib,
    ...
  }: let
    mountOptionType = with lib.types; coercedTo str (n: { name = n; }) (submodule {
      options = {
        name = lib.mkOption {
          type = str;
        };
        value = lib.mkOption {
          type = nullOr str;
          default = null;
        };
      };
    });
    mkPreserveList = dirOrFile: lib.mkOption {
      default = [];
      type = with lib.types; listOf (coercedTo str (path: { "${dirOrFile}" = path; }) (submodule {
        freeformType = attrsOf anything; 
      
        options = {
          "${dirOrFile}" = lib.mkOption { # Dynamically sets the key to "directory" or "file"
            type = str;
          };
          how = lib.mkOption {
            type = str;
            default = "bindmount";
          };
          mode = lib.mkOption {
            type = nullOr str;
            default = "0755"; 
          };
          mountOptions = lib.mkOption {
            type = listOf mountOptionType;
            default = [];
          };
        };
      }));
    };
  in {
    options = {
      host.preservation.preserveAt = lib.mkOption {
        default = {};
        type = with lib.types; attrsOf (submodule {
          options = {
            directories = mkPreserveList "directory";
            files       = mkPreserveList "file";
            commonMountOptions = lib.mkOption {
              type = listOf mountOptionType;
              default = [];
            };
          };
        });
      };
    };
  };
}