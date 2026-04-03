# Host system config
{ self, den, ... }: {
  den.aspects.ymir = {
    includes = with den.aspects; [
      # ---Core Config--- #
      boot._.systemd # Use systemd boot
      # CPU config
      hardware._.amdcpu._.enable
      # GPU config
      hardware._.amdgpu._.enable
      hardware._.amdgpu._.overclock

      # ---System Config--- #
      system-type._.basic
    ];

    _.to-users = {
      includes = with den.aspects; [
        # ---Core Config--- #
        system-type._.basic
      ];
    };

    _.gwen = {
      includes = [
        den._.primary-user
      ];
    };

    nixos = { lib, ... }: {
      # Set the default secrets file for this host
      sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";
      fileSystems."/".device = lib.mkDefault "/dev/fake"; # FIXME: Temp stub
    };
  };
}