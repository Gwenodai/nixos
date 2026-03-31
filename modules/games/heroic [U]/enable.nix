{ den, ... }: {
  den.aspects.heroic._.enable = den.lib.perUser {
    # Generic linux game directories that should be persisted by users
    includes = with den.aspects.game-libs._; [ game-persist ];

    homeManager = { pkgs, lib, ... }: {
      home.packages = with pkgs; [ heroic ];

      xdg.mimeApps.defaultApplications = lib.mkBefore (
        let
          application = "com.heroicgameslauncher.hgl.desktop";
          mimeTypes = [
            "x-scheme-handler/heroic"
          ];
        in lib.genAttrs mimeTypes (mimetype: application)
      );

      # Autostart
      xdg.configFile."autostart/com.heroicgameslauncher.hgl.desktop" = lib.mkDefault {
        text = ''
          [Desktop Entry]
          NotShowIn=niri
          Name=Heroic Games Launcher
          Exec=heroic
          Terminal=false
          SingleMainWindow=true
          Type=Application
          Icon=com.heroicgameslauncher.hgl
          StartupWMClass=heroic
          Categories=Game;
        '';
      };
    };

    persistUser = { hmConfig, ... }: {
      directories = [
        { directory = "${hmConfig.xdg.configHome}/heroic"; mode = "0700"; }
        "${hmConfig.xdg.dataHome}/heroic/games"
        "${hmConfig.xdg.dataHome}/heroic/prefixes"
      ];
    };

    persistUserTmp = { hmConfig, ... }: {
      "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      ".local" = {};                     # "~/.local"
      "${hmConfig.xdg.dataHome}" = {};   # "~/.local/share"
      "${hmConfig.xdg.dataHome}/heroic" = {};
    };

    persistUserIgnore = { hmConfig, ... }: {
      files = [ "${hmConfig.xdg.stateHome}/Heroic" ];
      directories = [ "${hmConfig.xdg.cacheHome}/winetricks" ];
    };
  };
}
