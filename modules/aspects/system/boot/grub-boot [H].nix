{ den, ... }:
{
  den.aspects.grub-boot = {
    nixos = {
      boot.loader.grub = {
        enable = true;
        useOSProber = true;
      };
    };
  };
}
