{
  flake.modules.nixos.systemd-boot = {
    pkgs,
    ...
  }: {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
    };
  };
}