{
  lib,
  ...
}:{
  # --- NIXOS MODULE ---
  flake.modules.nixos.kernel-default = {
    pkgs,
    ...
  }: {
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest; # Use latest kernel.
  };
}