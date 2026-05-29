{
  den.aspects.systemd-boot = {
    nixos = {
      boot = {
        initrd = {
          systemd.enable = true;
        };
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };
    };
  };
}
