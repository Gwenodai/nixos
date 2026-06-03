{ den, ... }:
{
  den.aspects.steam = {
    includes = with den.aspects; [
      # Generic linux game directories that should be persisted by users
      lib.games.savegame-persist
    ];

    nixos =
      { pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          extest.enable = true;
          localNetworkGameTransfers.openFirewall = true;

          package = pkgs.steam.override {
            extraEnv = {
              # Force Steam to fall back to XWayland (fixes various issues)
              NIXOS_OZONE_WL = "0";
              # Enable MangoHud for all Vulkan Steam games
              MANGOHUD = "1";
            };
          };

          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };

    homeManager =
      { pkgs, lib, ... }:
      {
        xdg.mimeApps.defaultApplications = (
          let
            application = "steam.desktop";
            mimeTypes = [
              "x-scheme-handler/steam"
              "x-scheme-handler/steamlink"
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application)
        );

        xdg.configFile."autostart/steam.desktop" = {
          text = ''
            [Desktop Entry]
            NotShowIn=niri
            Categories=Network;FileTransfer;Game;
            Exec=steam -silent
            GenericName=Internet Messenger
            Icon=steam
            Keywords=discord;vencord;electron;chat
            Name=Steam
            Type=Application
          '';
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.steam"
          ".steam"
          # "~/.local/share/Steam"
          {
            directory = "${hmConfig.xdg.dataHome}/Steam";
            mode = "0700";
          }
          # "~/.local/share/vulkan/implicit_layer.d"
          "${hmConfig.xdg.dataHome}/vulkan/implicit_layer.d"
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.local/share/vulkan"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
        "${hmConfig.xdg.dataHome}/vulkan" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/winetricks"
          "${hmConfig.xdg.cacheHome}/winetricks"
        ];
      };
  };
}
