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
        cli
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
        <vscode> # TODO: Replace with sublime text for regular desktop use
        <vscode/config>
      ];
    };

    desktop-gaming = {
      nixos.hardware.xone.enable = true; # Xbox One controllers

      includes = with den.aspects; [
        system-type.desktop # Inherit `desktop` system-type

        ### Core Aspects
        lact # GPU control
        ananicy # Auto-nice daemon

        ### Gaming Related Applications
        <heroic>
        <heroic/config>
        umu-launcher
        mangohud
        <vesktop>
        <vesktop/config>
      ];
    };
  };
}
