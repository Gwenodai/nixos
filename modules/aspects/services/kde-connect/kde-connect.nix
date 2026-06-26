# TODO: Finish this aspect, and add a persistUser config for it.
{
  den.aspects.kde-connect = {
    nixos = {
      programs.kdeconnect.enable = true;
    };

    homeManager = { lib, ... }: {
      services.kdeconnect = {
        enable = true;
        indicator = true;
      };

      xdg = {
        mimeApps = {
          defaultApplications =
            let
              application = "org.kde.kdeconnect.handler.desktop";
              mimeTypes = [
                "x-scheme-handler/tel"
                "x-scheme-handler/sms"
              ];
            in
            lib.genAttrs mimeTypes (_: application);
        };
      };
    };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/kdeconnect.app"
          {
            directory = "${hmConfig.xdg.cacheHome}/kdeconnect.app";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.cache/kdeconnect.daemon"
          {
            directory = "${hmConfig.xdg.cacheHome}/kdeconnect.daemon";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.cache/kdeconnect.sms"
          {
            directory = "${hmConfig.xdg.cacheHome}/kdeconnect.sms";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.config/kdeconnect"
          {
            directory = "${hmConfig.xdg.configHome}/kdeconnect";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.local/share/kpeople"
          {
            directory = "${hmConfig.xdg.dataHome}/kpeople";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.local/share/kpeoplevcard"
          {
            directory = "${hmConfig.xdg.dataHome}/kpeoplevcard";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };
    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.local/share"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
        # "~/.cache"
        "${hmConfig.xdg.cacheHome}" = { };
      };
    persistUserIgnore =
      { hmConfig, ... }:
      {
        files = [
          # "~/.local/state/kdeconnect.appstaterc"
          "${hmConfig.xdg.stateHome}/kdeconnect.appstaterc"
          # "~/.local/state/kdeconnect.smsstaterc"
          "${hmConfig.xdg.stateHome}/kdeconnect.smsstaterc"
          # "~/.local/share/user-places.xbel*"
          "${hmConfig.xdg.dataHome}/user-places.xbel*"
        ];
      };
  };
}
