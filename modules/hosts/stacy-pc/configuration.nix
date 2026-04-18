# Host system config
{ self, den, ... }: {
  den.aspects.stacy-pc = {
    includes = with den.aspects; [
      # ---Core Config--- #
      boot._.systemd # Use systemd boot
      # Kernel config
      kernel._.cachyos # Use the CachyOS kernel instead of the NixOS kernel
      # CPU config
      hardware._.amdcpu._.enable
      hardware._.amdcpu._.performance
      # GPU config
      hardware._.amdgpu._.enable
      hardware._.amdgpu._.overclock

      # ---System Config--- #
      system-type._.desktop._.gaming       # Use the gaming desktop system preset
      desktop-type._.window-manager._.niri # Use the Niri desktop preset

      # ---Services--- #
      kde-connect
    ];

    _.to-users = {
      includes = with den.aspects; [
        # ---Core Config--- #
        system-type._.desktop._.gaming
        desktop-type._.window-manager._.niri

        # ---Applications--- #
        spotify
        messaging._.messenger
      ];
    };

    _.stacy = {
      includes = [
        den._.primary-user
      ];
    };

    nixos = { lib, ... }: {
      # Set the default secrets file for this host
      sops.defaultSopsFile = self + "/secrets/stacy/secrets.yaml";
    };
  };
}