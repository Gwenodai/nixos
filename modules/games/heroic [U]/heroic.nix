{ den, ... }: {
  den.aspects.heroic = {
    includes = with den.aspects.heroic._; [ enable ];

    _.enable = den.lib.perUser {
      homeManager = { config, pkgs, lib, ... }: {
        home.packages = with pkgs; [ heroic ];

        systemd.user.tmpfiles.rules = [
          "d ${config.xdg.dataHome}/heroic/games"
          "d ${config.xdg.dataHome}/heroic/prefixes"
        ];

        home.file."${config.xdg.configHome}/heroic/config.json" = lib.mkDefault {
          text = lib.replaceStrings ["# syntax: json\n"] [""] ''
            # syntax: json
            {
              "defaultSettings": {
                "analyticsOptIn": false,
                "checkUpdatesInterval": 10,
                "enableUpdates": false,
                "addDesktopShortcuts": false,
                "addStartMenuShortcuts": false,
                "autoInstallDxvk": true,
                "autoInstallVkd3d": true,
                "autoInstallDxvkNvapi": true,
                "addSteamShortcuts": false,
                "preferSystemLibs": false,
                "checkForUpdatesOnStartup": false,
                "autoUpdateGames": true,
                "customWinePaths": [],
                "defaultInstallPath": "${config.xdg.dataHome}/heroic/games",
                "libraryTopSection": "recently_played_installed",
                "defaultSteamPath": "${config.home.homeDirectory}/.steam/steam",
                "defaultWinePrefix": "${config.xdg.dataHome}/heroic/prefixes",
                "hideChangelogsOnStartup": false,
                "language": "en",
                "maxWorkers": 0,
                "minimizeOnLaunch": false,
                "nvidiaPrime": false,
                "enviromentOptions": [],
                "wrapperOptions": [],
                "showFps": false,
                "useGameMode": false,
                "wineCrossoverBottle": "Heroic",
                "winePrefix": "${config.xdg.dataHome}/heroic/prefixes/default",
                "wineVersion": {
                  "bin": "${config.xdg.configHome}/heroic/tools/proton/GE-Proton-latest/proton",
                  "name": "GE-Proton-latest",
                  "type": "proton"
                },
                "enableEsync": true,
                "enableFsync": true,
                "enableMsync": false,
                "enableWineWayland": false,
                "enableHDR": false,
                "enableWoW64": false,
                "eacRuntime": true,
                "battlEyeRuntime": true,
                "framelessWindow": false,
                "beforeLaunchScriptPath": "",
                "afterLaunchScriptPath": "",
                "disableUMU": false,
                "verboseLogs": false,
                "downloadProtonToSteam": false,
                "advertiseAvxForRosetta": false,
                "noTrayIcon": false,
                "showValveProton": false,
                "showMangohud": true,
                "darkTrayIcon": false,
                "exitToTray": true,
                "startInTray": true
              },
              "version": "v0"
            }
          '';
          force = true;
        };

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
  };
}
