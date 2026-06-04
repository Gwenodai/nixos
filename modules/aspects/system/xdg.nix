{
  den.aspects.xdg = {
    # Ensure portal definitions and DE provided configurations get linked
    nixos = {
      environment.pathsToLink = [
        "/share/xdg-desktop-portal"
        "/share/applications"
      ];
    };

    homeManager =
      { config, pkgs, ... }:
      {
        xdg = {
          enable = true;
          mimeApps.enable = true;
          autostart.enable = true;

          userDirs =
            let
              docs = config.xdg.userDirs.documents;
            in
            {
              enable = config.xdg.enable;
              createDirectories = true;
              setSessionVariables = true;
              # Directories
              documents = "${config.home.homeDirectory}/Documents";
              desktop = "${docs}/Desktop";
              download = "${docs}/Downloads";
              pictures = "${docs}/Pictures";
              videos = "${docs}/Videos";
              music = "${docs}/Music";
              templates = "${docs}/Templates";
              publicShare = null;
            };

          dataFile."mimeapps.list" = {
            source = "${config.xdg.configFile."mimeapps.list".source}";
            force = true;
          };

          portal = {
            enable = config.xdg.enable;

            extraPortals = [
              pkgs.xdg-desktop-portal-gnome
              pkgs.xdg-desktop-portal-gtk
            ];

            config.common.default = [
              "gnome"
              "gtk"
            ];
          };
        };

        home = {
          # Programs use XDG dirs if supported
          preferXdgDirectories = config.xdg.enable;
          # Checks $HOME for unwanted files and directories.
          packages = with pkgs; [ xdg-ninja ];
        };
      };

    persistUser =
      { hmConfig, lib, ... }:
      {
        directories =
          lib.map
            (path: {
              directory = path;
              how = "symlink";
              createLinkTarget = true;
            })
            [
              "${hmConfig.xdg.userDirs.documents}"
              "${hmConfig.xdg.userDirs.desktop}"
              "${hmConfig.xdg.userDirs.download}"
              "${hmConfig.xdg.userDirs.pictures}"
              "${hmConfig.xdg.userDirs.videos}"
              "${hmConfig.xdg.userDirs.music}"
              "${hmConfig.xdg.userDirs.templates}"
            ];

        files = [
          {
            file = "${hmConfig.xdg.dataHome}/recently-used.xbel";
            mode = "0600";
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
      };
  };
}
