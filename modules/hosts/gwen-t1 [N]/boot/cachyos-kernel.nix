{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    pkgs,
    ...
  }: {
    # Latest CachyOS kernel with Zen4/5 specific optimizations
    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
  };
}