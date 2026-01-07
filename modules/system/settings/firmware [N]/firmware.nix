{
  flake.modules.nixos.firmware = {
    services.fwupd.enable = true;
    nixpkgs.config.allowUnfree = true; # enableAllFirmware depends on this
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
  };
}