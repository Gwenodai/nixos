{
  pkgs,
  inputs,
  hostname,
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

  # TODO: Split into seperate module
  # --- NETWORKING ---
  networking.hostName = hostname; 
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
