{ den, ... }:
{
  den.aspects.steam = {
    includes = with den.aspects; [
      # Generic linux game directories that should be persisted by users
      lib.games.persist-savegame
    ];

    nixos =
      {
        pkgs,
        user,
        lib,
        ...
      }:
      {
        programs.steam = {
          enable = true;
          extest.enable = true;
          localNetworkGameTransfers.openFirewall = true;

          package = pkgs.steam.override {
            extraEnv = {
              # Force Steam to fall back to XWayland (fixes various issues)
              NIXOS_OZONE_WL = "0";
              WINEDLLOVERRIDES = "dinput8,dxgi,dsound.dll=n,b";
            }
            # Enable MangoHud for all Vulkan Steam games if `mangohud` aspect is included
            // lib.optionalAttrs (lib.elem "mangohud" user.activeAspects) {
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
          # "~/.local/share/Steam"
          {
            directory = "${hmConfig.xdg.dataHome}/Steam";
            mode = "0700";
          }
          # "~/.local/share/vulkan/implicit_layer.d"
          "${hmConfig.xdg.dataHome}/vulkan/implicit_layer.d"
        ];
        files = [
          # "~/.steam/steam/registry.vdf"
          {
            file = "${hmConfig.home.homeDirectory}/.steam/registry.vdf";
            mode = "0755";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.steam"
        ".steam" = { };
        # "~/.local/share/vulkan"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
        "${hmConfig.xdg.dataHome}/vulkan" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.steam"
          ".steam"
          # "~/.cache/winetricks"
          "${hmConfig.xdg.cacheHome}/winetricks"
        ];
      };
  };
}
