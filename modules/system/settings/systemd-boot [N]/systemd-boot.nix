{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.systemd-boot = {
    pkgs,
    lib,
    ...
  }: {
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
}