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
        host,
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
              PROTON_DISCORD_BRIDGE = "1";
            }
            # Enable MangoHud for all Vulkan Steam games if `mangohud` aspect is included
            // lib.optionalAttrs (lib.elem "mangohud" host.activeAspects) {
              MANGOHUD = "1";
            };
          };

          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };

    homeManager =
      { lib, ... }:
      {
        xdg.mimeApps.defaultApplications =
          let
            application = "steam.desktop";
            mimeTypes = [
              "x-scheme-handler/steam"
              "x-scheme-handler/steamlink"
            ];
          in
          lib.genAttrs mimeTypes (_: application);

        xdg.configFile."autostart/steam.desktop" = {
          text = ''
            [Desktop Entry]
            NotShowIn=niri
            Name=Steam
            Comment=Application for managing and playing games on Steam
            Exec=steam -silent
            Icon=steam
            Terminal=false
            Type=Application
            Categories=Network;FileTransfer;Game;
            MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
            Actions=Store;Community;Library;Servers;Screenshots;News;Settings;BigPicture;Friends;
            PrefersNonDefaultGPU=true
            X-KDE-RunOnDiscreteGpu=true
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
