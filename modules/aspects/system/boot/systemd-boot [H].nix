{ den, ... }:
{
  den.aspects.systemd-boot = den.lib.perHost {
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
