{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
      ./hardware-configuration.nix  # Include the results of the hardware scan
  ];

  # --- BOOTLOADER ---
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.

  # --- NETWORKING ---
  networking.hostName = "gwen-t1"; 
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # --- AUDIO ---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- GRAPHICAL INTERFACE ---
  services.xserver = {
    enable = false; # Enable the X11 windowing system.
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # --- FONTS ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
