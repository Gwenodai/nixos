{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.systemd-boot = {
    pkgs,
    ...
  }: {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      # TODO: Make kernel settings and move this
      kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
    };
  };
}