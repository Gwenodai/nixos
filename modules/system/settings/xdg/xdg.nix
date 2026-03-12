{ inputs, den, ... }: {
  den.aspects.xdg = {
    nixos = {
      # Ensure portal definitions and DE provided configurations get linked
      environment.pathsToLink = [
        "/share/xdg-desktop-portal"
        "/share/applications"
      ];
    };

    homeManager = { config, pkgs, lib, ... }: {
      xdg = {
        enable = lib.mkDefault true;
        mimeApps.enable = lib.mkDefault true;
        autostart.enable = lib.mkDefault true;

        userDirs = let
          docs = config.xdg.userDirs.documents;
        in
        inputs.self.lib.applyDefaults {
          enable = config.xdg.enable;
          createDirectories = false;
          # Directories
          documents   = "${config.home.homeDirectory}/Documents";
          desktop     = "${docs}/Desktop";
          download    = "${docs}/Downloads";
          pictures    = "${docs}/Pictures";
          videos      = "${docs}/Videos";
          music       = "${docs}/Music";
          templates   = "${docs}/Templates";
          publicShare = null;
        };

        dataFile."mimeapps.list" = lib.mkDefault {
          source = "${config.xdg.configFile."mimeapps.list".source}";
          force = true;
        };

        portal = {
          enable = lib.mkDefault config.xdg.enable;
          extraPortals = lib.mkDefault [
            pkgs.xdg-desktop-portal-gnome
            pkgs.xdg-desktop-portal-gtk
          ];
          config = {
            common = {
              default = lib.mkDefault [
                "gnome"
                "gtk"
              ];
            };
          };
        };
      };

      home = {
        # Programs use XDG dirs if supported
        preferXdgDirectories = lib.mkDefault config.xdg.enable;

        packages = with pkgs; [
          xdg-ninja # Checks $HOME for unwanted files and directories.
        ];
      };
    };
  };

  # Include XDG config by default in all hm users
  den.ctx.hm-user.includes = [ den.aspects.xdg ];
}