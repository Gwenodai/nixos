{
  flake.modules.nixos.grub-boot = {
    pkgs,
    ...
  }:

  {
    boot = {
      loader = {
        grub.enable = true;
        grub.device = "/dev/vda";
        grub.useOSProber = true;
      };
      kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
    };
  };
}