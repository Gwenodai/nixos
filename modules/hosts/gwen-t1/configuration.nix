# Host system config
{ self, den, ... }: {
  den.aspects.gwen-t1 = {
    includes = with den.aspects; [
      # ---Core Config--- #
      persist        # Enable persistence
      boot._.systemd # Use systemd boot
      # Kernel config
      kernel._.cachyos        # Use the CachyOS kernel instead of the NixOS kernel
      kernel._.modules._.it87 # Driver for MB fan control (needed for AIO)
      # CPU config
      hardware._.amdcpu._.enable
      hardware._.amdcpu._.performance
      # GPU config
      hardware._.amdgpu._.enable
      hardware._.amdgpu._.overclock

      # ---System Config--- #
      system-type._.desktop._.gaming # Use the gaming system preset
      # niri
    ];

    _.to-users = {
      includes = with den.aspects; [
        persist # Enable persistence for all users
        # niri
        # noctalia
      ];
    };
    
    nixos = { lib, ... }: {
      # Set the default secrets file for this host
      sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";
    };
  };
}