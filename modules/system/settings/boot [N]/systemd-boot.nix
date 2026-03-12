{
  den.aspects.boot.provides.systemd-boot = {
    nixos = { lib, ... }: {
      boot = {
        initrd = {
          systemd.enable = lib.mkDefault true;
        };

        loader = {
          systemd-boot.enable = lib.mkDefault true;
          efi.canTouchEfiVariables = lib.mkDefault true;
        };
      };
    };
  };
}