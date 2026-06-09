{ den, ... }:
{
  den.aspects.system-type = {
    basic = {
      includes = with den.aspects; [
        ### Core Aspects
        nix
        home-manager
        disko
        # Automatically configures core hardware functionality based on the provided
        # host hardware profile configuration defined within `./hosts.nix`
        hardware.autoConfig
        firmware
        garbage-collection
        locale
        # Use the latest NixOS kernel by default
        kernel
        sops-nix
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

        ## Security
        gnome-keyring
        polkit-gnome
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
