# Passthrough of defined tmpfiles options within Home Manager
# for use at a system level as needed for Preservation
{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    config,
    lib,
    ...
  }: {
    # Construct proper NixOS level `systemd.tmpfiles.settings.preservation`
    # config from HM `setupDirectories` declarations
    systemd.tmpfiles.settings.preservation = lib.mkMerge (
      lib.flatten (
        lib.mapAttrsToList (
          username: userConfig:
          lib.mapAttrsToList (
            dirPath: dirConfig:
            let
              absPath = # Convert relative path to absolute: ".config" -> "/home/gwen/.config"
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
          ) userConfig.preservation.setupDirectories # = `dirPath`.`dirConfig`
        ) config.home-manager.users # = `username`.`userConfig`
      )
    );
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.preservation = {
    lib,
    ...
  }: {
    # Define options available for use within Home Manager
    options = {
      preservation.setupDirectories = lib.mkOption {
        description = "Create directories with specific permissions via systemd-tmpfiles";
        default = {};
        type = with lib.types; attrsOf (
          submodule {
            options = {

              mode = lib.mkOption {
                type = str;
                default = "0755";
              };

              user = lib.mkOption {
                type = nullOr str;
                default = null;
              };

              group = lib.mkOption {
                type = nullOr str;
                default = null;
              };
            };
          }
        );
      };
    };
  };
}