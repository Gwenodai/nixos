{ den, ... }:
{
  den.aspects.grub-boot = den.lib.perHost {
    nixos = {
      boot.loader.grub = {
        enable = true;
        useOSProber = true;
      };
    };
  };
}
