{ den, ... }: {
  den.aspects.steam = {
    includes = with den.aspects.steam._; [ enable ];
    
    # https://mynixos.com/nixpkgs/options/programs.steam
    _.enable = den.lib.perUser {
      nixos = { pkgs, lib, ... }: {
        programs.steam = {
          enable = lib.mkDefault true;

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
        xdg.configFile."autostart/steam.desktop".text = ''
          [Desktop Entry]
          NotShowIn=niri
          Categories=Network;FileTransfer;Game;
          Exec=${pkgs.steam}/bin/steam -silent
          GenericName=Internet Messenger
          Icon=steam
          Keywords=discord;vencord;electron;chat
          Name=Steam
          Type=Application
        '';
      };

      persistUser = { hmConfig, ... }: {
        directories = [
          { directory = ".steam"; how = "symlink"; createLinkTarget = true; }
          {
            directory = "${hmConfig.xdg.dataHome}/Steam";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
          {
            directory = "${hmConfig.xdg.dataHome}/vulkan/implicit_layer.d";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                   # "~/.local"
        "${hmConfig.xdg.dataHome}" = {}; # "~/.local/share"
        "${hmConfig.xdg.dataHome}/vulkan" = {};
      };
    };
  };
}
