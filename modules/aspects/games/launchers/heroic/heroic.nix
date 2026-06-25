{ den, ... }:
{
  den.aspects.heroic = {
    includes = with den.aspects; [
      # Generic linux game directories that should be persisted by users
      lib.games.persist-savegame
    ];

    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [ heroic ];

        xdg.mimeApps.defaultApplications =
          let
            application = "com.heroicgameslauncher.hgl.desktop";
            mimeTypes = [
              "x-scheme-handler/heroic"
            ];
          in
          lib.genAttrs mimeTypes (_: application);

        xdg.configFile."autostart/com.heroicgameslauncher.hgl.desktop" = {
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
            Comment=An Open Source Launcher for GOG, Epic Games and Amazon Games
            Comment[de]=Ein OSS-Spielelauncher für GOG, Epic Games und Amazon Games
            Comment[pl]=Otwartoźródłowy launcher dla GOG, Epic Games i Amazon Games
            Comment[tr]=Açık Kaynaklı GOG ve Epic Games başlatıcısı
            MimeType=x-scheme-handler/heroic;
            Categories=Game;
          '';
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/heroic"
          {
            directory = "${hmConfig.xdg.configHome}/heroic";
            mode = "0700";
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.local/state/Heroic"
          "${hmConfig.xdg.stateHome}/Heroic"
          # "~/.cache/winetricks"
          "${hmConfig.xdg.cacheHome}/winetricks"
        ];
      };
  };
}
