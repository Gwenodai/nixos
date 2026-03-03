{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.xdg = {
    options,
    config,
    lib,
    ...
  }: {
    config = inputs.self.lib.mkIfPreservation { inherit options; } {
      host.preservation = {
        preserveAt."/persist" = {
          directories = map (path: {
            directory = path;
            how = "symlink";
            createLinkTarget = true;
          }) [
            "${config.xdg.userDirs.documents}"
            "${config.xdg.userDirs.desktop}"
            "${config.xdg.userDirs.download}"
            "${config.xdg.userDirs.pictures}"
            "${config.xdg.userDirs.videos}"
            "${config.xdg.userDirs.music}"
            "${config.xdg.userDirs.templates}"
          ];

          files = [
            {
              file = "${config.xdg.dataHome}/recently-used.xbel";
              mode = "0600";
            }
          ];
        };
        
        setupDirectories = {
          ".local" = { };                 # "~/.local"
          "${config.xdg.dataHome}" = { }; # "~/.local/share"
        };
      };
    };
  };
}