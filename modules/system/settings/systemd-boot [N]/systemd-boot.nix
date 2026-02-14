{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.systemd-boot = {
    pkgs,
    lib,
    ...
  }: {
    boot = {
      initrd = {
        systemd.enable = true;
      };

      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}