{
  den.aspects.boot = {
    provides.grub = {
      nixos = { lib, ... }: {
        boot.loader.grub = {
          enable = lib.mkDefault true;
          useOSProber = lib.mkDefault true;
        };
      };
    };
    
    provides.systemd = {
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
  };
}