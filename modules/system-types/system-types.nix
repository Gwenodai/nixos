{ den, ... }:
{
  den.aspects.system-type = {
    basic = {
      includes = with den.aspects; [
        #---System Foundation---#
        nix
        home-manager
        disko
        sops-nix
        xdg

        #---Hardware & Base Platform---#
        # Automatically configures core hardware functionality based on the provided
        # host hardware profile configuration defined within `./hosts.nix`
        hardware.autoConfig
        firmware
        kernel # Use the latest NixOS kernel
        networking
        coolercontrol
        garbage-collection
        locale

        #---Shells & Addons---#
        zsh
        bash
        ## Prompt & Styles
        starship

        #---CLI Utilities---#
        ssh
        git
        cli-tools
      ];
    };

    desktop = {
      includes = with den.aspects; [
        # Inherit `basic` system-type
        system-type.basic

        #---Display & Media---#
        gdm
        audio
        fonts

        #---Security & Authentication---#
        gnome-keyring
        polkit-base
      ];
    };

    desktop-gaming = {
      nixos = {
        environment.sessionVariables = {
          MESA_SHADER_CACHE_MAX_SIZE = "16G";
        };
        # Xbox One controller support
        hardware.xone.enable = true;
      };

      includes = with den.aspects; [
        # Inherit `desktop` system-type
        system-type.desktop

        #---Performance & Tuning---#
        lact # GPU control
        ananicy # Auto-nice daemon

        #---Runtime Tools & Overlays---#
        umu-launcher
        mangohud
      ];
    };
  };
}
