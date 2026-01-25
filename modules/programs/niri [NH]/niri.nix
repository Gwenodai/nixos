{
  inputs,
  ...
}: {
  flake.modules.nixos.niri = { pkgs, ... }: {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
    environment.systemPackages = [ pkgs.xwayland-satellite ];
  };

  flake.modules.homeManager.niri = { pkgs, ... }: {
    imports = [
      inputs.niri.homeModules.niri
      inputs.niri.homeModules.config
    ];
    programs.niri.enable = true;

    programs.niri.settings = {
      spawn-at-startup = [
        { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
      ];

      binds = {
        "Mod+Return" = { spawn = [ "kitty" ]; };
        "Mod+D" = { spawn = [ "fuzzel" ]; };
        "Mod+Shift+E" = { quit = []; };
        "Mod+Q" = { close-window = []; };
        "Mod+L" = { spawn = [ "swaylock" ]; };

        "Mod+Left" = { focus-column-left = []; };
        "Mod+Right" = { focus-column-right = []; };
        "Mod+Down" = { focus-window-down = []; };
        "Mod+Up" = { focus-window-up = []; };

        "Mod+Shift+Left" = { move-column-left = []; };
        "Mod+Shift+Right" = { move-column-right = []; };
      };
    };
  };
}
