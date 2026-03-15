{ den, ... }: {
  
  den.aspects.messaging._.messenger = {
    includes = with den.aspects.messaging._.messenger._; [ caprine ];
    
    _.caprine = {
      homeManager = { pkgs, lib, ... }: {
        home.packages = [ pkgs.caprine ];

        # Autostart
        xdg.configFile."autostart/caprine.desktop".text = ''
          [Desktop Entry]
          NotShowIn=niri
          Categories=Network;InstantMessaging;Chat
          Comment=Elegant Facebook Messenger desktop app
          Exec=${pkgs.caprine}/bin/caprine
          Icon=caprine
          MimeType=x-scheme-handler/caprine
          Name=Caprine
          Terminal=false
          Type=Application
          Version=1.5
        '';
      };

      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/Caprine";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      };
    };
  };
}
