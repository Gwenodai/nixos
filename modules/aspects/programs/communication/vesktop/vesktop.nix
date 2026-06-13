{
  den.aspects.vesktop = {
    homeManager = {
      programs.vesktop.enable = true;

      xdg.configFile."autostart/vesktop.desktop" = {
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

      services.arrpc = {
        enable = true;
        systemdTarget = "graphical-session.target";
      };
    };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/vesktop/sessionData"
          {
            directory = "${hmConfig.xdg.configHome}/vesktop/sessionData";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
        files = [
          # "~/.config/vesktop/Crashpad/client_id"
          {
            file = "${hmConfig.xdg.configHome}/vesktop/Crashpad/client_id";
            mode = "0644";
          }
          # "~/.config/vesktop/state.json"
          {
            file = "${hmConfig.xdg.configHome}/vesktop/state.json";
            mode = "0644";
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.config/vesktop"
        "${hmConfig.xdg.configHome}" = { };
        "${hmConfig.xdg.configHome}/vesktop" = { };
        # "~/.config/vesktop/Crashpad"
        "${hmConfig.xdg.configHome}/vesktop/Crashpad" = {
          mode = "0700";
        };
        # "~/.config/vesktop/sessionData"
        "${hmConfig.xdg.configHome}/vesktop/sessionData" = {
          mode = "0700";
        };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        files = [
          # "~/.config/vesktop/settings/quickCss.css"
          "${hmConfig.xdg.configHome}/vesktop/settings/quickCss.css"
        ];
      };
  };
}
