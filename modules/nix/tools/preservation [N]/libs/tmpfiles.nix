# Passthrough of defined tmpfiles options within Home Manager
# for use at a system level as needed for Preservation
{
  flake.modules.nixos.preservation = {
    config,
    lib,
    ...
  }: {
    config = {
      # Construct a proper NixOS level `systemd.tmpfiles.settings.preservation`
      # from all HM `setupDirectories` declarations
      systemd.tmpfiles.settings.preservation = lib.mkMerge (
        lib.flatten (
          lib.mapAttrsToList (
            username: userConfig:
            lib.mapAttrsToList (
              dirPath: dirConfig:
              let
                # Convert relative path to absolute: ".config" -> "/home/gwen/.config"
                absPath =
                  if lib.hasPrefix "/" dirPath then
                    dirPath 
                  else
                    "${userConfig.home.homeDirectory}/${dirPath}";
              in {
                "${absPath}".d = {
                  mode = dirConfig.mode;
                  user =
                    if dirConfig.user != null then
                      dirConfig.user
                    else
                      username;
                  group =
                    if dirConfig.group != null then
                      dirConfig.group
                    else
                      "users";
                };
              }
            ) userConfig.home.preservation.setupDirectories # = `dirPath`.`dirConfig`
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
      home.preservation.setupDirectories = lib.mkOption {
        description = "Create directories with specific permissions via systemd-tmpfiles";
        default = {};
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {

              mode = lib.mkOption {
                type = lib.types.str;
                default = "0755";
              };

              user = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
              };

              group = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
              };
            };
          }
        );
      };
    };
  };
}