{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.grub-boot = {
    pkgs,
    ...
  }: {
    boot = {
      loader = {
        grub.enable = true;
        grub.device = "/dev/vda";
        grub.useOSProber = true;
      };
      # TODO: Make kernel settings and move this
      kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
    };
  };
}