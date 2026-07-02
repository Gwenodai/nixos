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
              ### Directories
              documents = "${config.home.homeDirectory}/Documents";
              desktop = "${docs}/Desktop";
              download = "${docs}/Downloads";
              pictures = "${docs}/Pictures";
              videos = "${docs}/Videos";
              music = "${docs}/Music";
              templates = "${docs}/Templates";
              projects = null;
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

    ### Persist config
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
              # "~/Documents"
              "${hmConfig.xdg.userDirs.documents}"
              # # "~/Documents/Desktop"
              # "${hmConfig.xdg.userDirs.desktop}"
              # # "~/Documents/Downloads"
              # "${hmConfig.xdg.userDirs.download}"
              # # "~/Documents/Pictures"
              # "${hmConfig.xdg.userDirs.pictures}"
              # # "~/Documents/Videos"
              # "${hmConfig.xdg.userDirs.videos}"
              # # "~/Documents/Music"
              # "${hmConfig.xdg.userDirs.music}"
              # # "~/Documents/Templates"
              # "${hmConfig.xdg.userDirs.templates}"
            ];

        files = [
          # "~/.local/share/recently-used.xbel"
          {
            file = "${hmConfig.xdg.dataHome}/recently-used.xbel";
            mode = "0600";
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.local/share"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
      };
  };
}
