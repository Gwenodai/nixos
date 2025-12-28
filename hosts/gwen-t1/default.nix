{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
      ./hardware-configuration.nix  # Include the results of the hardware scan
      ../../modules/nixos/desktop.nix # Import the common desktop config
  ];

  # --- BOOTLOADER ---
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
}
