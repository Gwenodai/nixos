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
    systemd.tmpfiles.settings.preservation = with lib; mkMerge (
      flatten (
        mapAttrsToList (
          username: userConfig:
          mapAttrsToList (
            dirPath: dirConfig:
            let
              absPath = # Convert relative path to absolute: ".config" -> "/home/gwen/.config"
                if hasPrefix "/" dirPath then
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
<<<<<<< HEAD
      home.preservation.setupDirectories = with lib; mkOption {
=======
      preservation.setupDirectories = with lib; mkOption {
>>>>>>> dms
        description = "Create directories with specific permissions via systemd-tmpfiles";
        default = {};
        type = with types; attrsOf (
          submodule {
            options = {

              mode = mkOption {
                type = str;
                default = "0755";
              };

              user = mkOption {
                type = nullOr str;
                default = null;
              };

              group = mkOption {
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