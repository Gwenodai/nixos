{ den, ... }: {
  den.aspects.messaging._.discord._.vesktop._.enable = den.lib.perUser {
    homeManager = { pkgs, lib, ... }: {
      programs.vesktop.enable = lib.mkDefault true;

      # Autostart
      xdg.configFile."autostart/vesktop.desktop" = lib.mkDefault {
        text = ''
          [Desktop Entry]
          NotShowIn=niri
          Categories=Network;InstantMessaging;Chat
          Exec=vesktop --start-minimized
          GenericName=Internet Messenger
          Icon=vesktop
          Keywords=discord;vencord;electron;chat
          Name=Vesktop
          StartupWMClass=Vesktop
          Type=Application
          Version=1.5
        '';
      };
    };

    persistUser = { hmConfig, ... }: {
      directories = [
        {
          directory = "${hmConfig.xdg.configHome}/vesktop/sessionData";
          how = "symlink";
          mode = "0700";
          createLinkTarget = true;
        }
      ];
      files = [
        { file = "${hmConfig.xdg.configHome}/vesktop/Crashpad/client_id"; mode = "0644"; }
        { file = "${hmConfig.xdg.configHome}/vesktop/state.json"; mode = "0644"; }
      ];
    };

    persistUserTmp = { hmConfig, ... }: {
      "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      "${hmConfig.xdg.configHome}/vesktop" = {};
      "${hmConfig.xdg.configHome}/vesktop/Crashpad" = { mode = "0700"; };
      "${hmConfig.xdg.configHome}/vesktop/sessionData" = { mode = "0700"; };
    };

    persistUserIgnore = { hmConfig, ... }: {
      files = [ "${hmConfig.xdg.configHome}/vesktop/settings/quickCss.css" ];
    };
  };
}
