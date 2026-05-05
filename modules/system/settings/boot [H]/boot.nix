{ den, ... }:
{
  den.aspects.boot = {
    _.grub = den.lib.perHost {
      nixos =
        { lib, ... }:
        {
          boot.loader.grub = {
            enable = lib.mkDefault true;
            useOSProber = lib.mkDefault true;
          };
        };
    };

    _.systemd = den.lib.perHost {
      nixos =
        { lib, ... }:
        {
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
  };
}
