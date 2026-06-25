{
  den.aspects.caprine = {
    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = [ pkgs.caprine ];

        xdg = {
          mimeApps = {
            defaultApplications =
              let
                application = "caprine.desktop";
                mimeTypes = [
                  "x-scheme-handler/caprine"
                ];
              in
              lib.genAttrs mimeTypes (_: application);
          };

          configFile."autostart/caprine.desktop" = {
            text = ''
              [Desktop Entry]
              NotShowIn=niri
              Categories=Network;InstantMessaging;Chat
              Comment=Elegant Facebook Messenger desktop app
              Exec=caprine
              Icon=caprine
              MimeType=x-scheme-handler/caprine
              Name=Caprine
              Terminal=false
              Type=Application
              Version=1.5
            '';
          };
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/Caprine"
          {
            directory = "${hmConfig.xdg.configHome}/Caprine";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
      };
  };
}
