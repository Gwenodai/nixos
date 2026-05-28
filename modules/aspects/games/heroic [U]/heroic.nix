{ den, __findFile, ... }:
let
  heroicLauncher = {
    # Generic linux game directories that should be persisted by users
    includes = [ <lib/games/savegame-persist> ];

    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [ heroic ];

        xdg.mimeApps.defaultApplications = (
          let
            application = "com.heroicgameslauncher.hgl.desktop";
            mimeTypes = [
              "x-scheme-handler/heroic"
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application)
        );

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
            Categories=Game;
          '';
        };
      };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/heroic";
            mode = "0700";
          }
          "${hmConfig.xdg.dataHome}/heroic/games"
          "${hmConfig.xdg.dataHome}/heroic/prefixes"
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
        "${hmConfig.xdg.dataHome}/heroic" = { };
        "${hmConfig.xdg.configHome}" = { }; # "~/.config"
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        files = [ "${hmConfig.xdg.stateHome}/Heroic" ];
        directories = [ "${hmConfig.xdg.cacheHome}/winetricks" ];
      };
  };
in
{
  den.aspects.heroic.includes = [ heroicLauncher ];
}
