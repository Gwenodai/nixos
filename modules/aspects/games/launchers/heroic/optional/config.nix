{
  den.aspects.heroic.config = {
    homeManager =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        systemd.user.tmpfiles.rules = [
          "d ${config.xdg.dataHome}/heroic/games"
          "d ${config.xdg.dataHome}/heroic/prefixes"
        ];

        home.file."${config.xdg.configHome}/heroic/config.json" = {
          text = lib.replaceStrings [ "# syntax: json\n" ] [ "" ] ''
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
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.local/share/heroic/..."
          "${hmConfig.xdg.dataHome}/heroic/games"
          "${hmConfig.xdg.dataHome}/heroic/prefixes"
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.local/share/heroic"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
        "${hmConfig.xdg.dataHome}/heroic" = { };
      };
  };
}
