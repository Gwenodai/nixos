{
  den.aspects.boot.provides.grub-boot = {
    nixos = { lib, ... }: {
      boot.loader.grub = {
        enable = lib.mkDefault true;
        useOSProber = lib.mkDefault true;
      };
    };
  };
}