{ den, __findFile, ... }: {
  # https://mynixos.com/nixpkgs/options/programs.steam
  den.aspects.steam = {
    # The `enable` sub-aspect is included when the generic 'steam' aspect is used
    includes = with den.aspects.steam._; [ enable ];

    _.enable = den.lib.perUser {
      # Generic linux game directories that should be persisted by users
      includes = [ <lib/games/savegame-persist> ];

      nixos = { pkgs, lib, ... }: {
        programs.steam = {
          enable = lib.mkDefault true;

          package = pkgs.steam.override {
            extraEnv = {
              NIXOS_OZONE_WL = "0";
              MANGOHUD = "1";
            };
          };

          extest.enable = lib.mkDefault true;
          localNetworkGameTransfers.openFirewall = lib.mkDefault true;

          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };

      homeManager = { pkgs, lib, ... }: {
        xdg.mimeApps.defaultApplications = lib.mkBefore (
          let
            application = "steam.desktop";
            mimeTypes = [
              "x-scheme-handler/steam"
              "x-scheme-handler/steamlink"
            ];
          in lib.genAttrs mimeTypes (mimetype: application)
        );

        # Autostart
        xdg.configFile."autostart/steam.desktop" = lib.mkDefault {
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

      persistUser = { hmConfig, ... }: {
        directories = [
          ".steam"
          { directory = "${hmConfig.xdg.dataHome}/Steam"; mode = "0700"; }
          "${hmConfig.xdg.dataHome}/vulkan/implicit_layer.d"
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                   # "~/.local"
        "${hmConfig.xdg.dataHome}" = {}; # "~/.local/share"
        "${hmConfig.xdg.dataHome}/vulkan" = {};
      };

      persistUserIgnore = { hmConfig, ... }: {
        directories = [ "${hmConfig.xdg.cacheHome}/winetricks" ];
      };
    };
  };
}
