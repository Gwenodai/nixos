{
  pkgs,
  ...
}:

{
  imports = [
      ./hardware-configuration.nix  # Include the results of the hardware scan
      ../../modules/nixos/optional/desktop.nix # Import the desktop config
  ];

  # --- BOOTLOADER ---
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
}
