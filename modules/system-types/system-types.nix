{ __findFile, den, ... }:
{
  den.aspects.system-type = {
    basic = {
      includes = with den.aspects; [
        ### Core Aspects
        xdg

        ### Basic Tools
        coolercontrol
        ssh
        cli-tools
        git

        ### Shells
        zsh
        bash
        starship
      ];
    };

    desktop = {
      includes = with den.aspects; [
        system-type.basic # Inherit `basic` system-type

        ### Core Aspects
        gdm
        audio
        fonts
        # Security aspects
        gnome-keyring
        polkit-gnome

        ### Basic Desktop Applications
        kitty
        nemo
      ];
    };

    desktop-gaming = {
      nixos.hardware.xone.enable = true; # Xbox One controllers

      includes = with den.aspects; [
        system-type.desktop # Inherit `desktop` system-type

        ### Core Aspects
        lact # GPU control
        ananicy # Auto-nice daemon

        ### Gaming Related Aspects
        umu-launcher
        mangohud
      ];
    };
  };
}
