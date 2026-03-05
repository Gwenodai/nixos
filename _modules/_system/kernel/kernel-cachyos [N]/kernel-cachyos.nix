{
  inputs,
  lib,
  ...
}:{
  # --- NIXOS MODULE ---
  flake.modules.nixos.kernel-cachyos = {
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
    ];

    nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
    nix.settings.trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
    
    boot.kernelPackages = lib.mkOverride 900 pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  };
}