{ den, __findFile, ... }:
let
  hostConfig = {
    nixos =
      { pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          extest.enable = true;
          localNetworkGameTransfers.openFirewall = true;

          package = pkgs.steam.override {
            extraEnv = {
              NIXOS_OZONE_WL = "0";
              MANGOHUD = "1";
            };
          };

          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };
  };

  userConfig = {
    includes = [
      # Generic linux game directories that should be persisted by users
      <lib/games/savegame-persist>
    ];

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

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          ".steam"
          {
            directory = "${hmConfig.xdg.dataHome}/Steam";
            mode = "0700";
          }
          "${hmConfig.xdg.dataHome}/vulkan/implicit_layer.d"
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
        "${hmConfig.xdg.dataHome}/vulkan" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [ "${hmConfig.xdg.cacheHome}/winetricks" ];
      };
  };
in
{
  # https://mynixos.com/nixpkgs/options/programs.steam
  den.aspects.steam.includes = [
    hostConfig
    userConfig
  ];
}
