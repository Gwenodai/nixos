{
  den.aspects.xdg = {
    provides.persist = {
      persistUser = { hmConfig, ... }: {
        directories = map (path: {
          directory = path;
          how = "symlink";
          createLinkTarget = true;
        }) [
          "${hmConfig.xdg.userDirs.documents}"
          "${hmConfig.xdg.userDirs.desktop}"
          "${hmConfig.xdg.userDirs.download}"
          "${hmConfig.xdg.userDirs.pictures}"
          "${hmConfig.xdg.userDirs.videos}"
          "${hmConfig.xdg.userDirs.music}"
          "${hmConfig.xdg.userDirs.templates}"
        ];

        files = [
          { file = "${hmConfig.xdg.dataHome}/recently-used.xbel"; mode = "0600"; }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                   # "~/.local"
        "${hmConfig.xdg.dataHome}" = {}; # "~/.local/share"
      };
    };
  };
}