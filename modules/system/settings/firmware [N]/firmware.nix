{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.firmware = {
    lib,
    ...
  }: {
    services.fwupd.enable = lib.mkDefault true;
    nixpkgs.config.allowUnfree = lib.mkDefault true; # enableAllFirmware depends on this
    hardware = {
      enableAllFirmware = lib.mkDefault true;
      enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}