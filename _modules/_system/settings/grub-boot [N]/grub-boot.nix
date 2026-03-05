{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.grub-boot = {
    pkgs,
    lib,
    ...
  }: {
    boot.loader.grub = {
      enable = lib.mkDefault true;
      device = lib.mkDefault "/dev/vda";
      useOSProber = lib.mkDefault true;
    };
  };
}