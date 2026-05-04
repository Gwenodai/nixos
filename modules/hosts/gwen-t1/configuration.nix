# Host system config
{ self, den, ... }:
{
  den.aspects.gwen-t1 = {
    includes = with den.aspects; [
      # ---Core Config--- #
      persist # Enable persistence
      boot._.systemd # Use systemd boot
      # Kernel config
      kernel._.cachyos # Use the CachyOS kernel instead of the NixOS kernel
      kernel._.modules._.it87 # Driver for MB fan control (needed for AIO)
      # CPU config
      hardware._.amdcpu._.enable
      hardware._.amdcpu._.performance
      # GPU config
      hardware._.amdgpu._.enable
      hardware._.amdgpu._.overclock

      # ---System Config--- #
      system-type._.desktop._.gaming # Use the gaming desktop system preset
      desktop-type._.window-manager._.niri # Use the Niri desktop preset

      # ---Services--- #
      kde-connect
    ];

    _.to-users = {
      includes = with den.aspects; [
        # ---Core Config--- #
        persist # Enable persistence for all users
        system-type._.desktop._.gaming
        desktop-type._.window-manager._.niri
        noctalia._.settings # Use pre-configured settings

        # ---Applications--- #
        spotify
        messaging._.messenger
      ];
    };

    _.gwen = {
      includes = with den.aspects; [
        den._.primary-user
        dconf-editor
      ];
    };

    nixos =
      { lib, ... }:
      {
        # Set the default secrets file for this host
        sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";
      };
  };
}
