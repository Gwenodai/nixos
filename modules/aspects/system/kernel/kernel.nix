{ inputs, ... }:
{
  # Regular NixOS kernel
  den.aspects.kernel = {
    nixos =
      { pkgs, lib, ... }:
      {
        boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      };
  };

  # CachyOS kernel for NixOS
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  den.aspects.kernel.cachyos = {
    nixos =
      { pkgs, lib, ... }:
      {
        nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
        nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
        nix.settings.trusted-public-keys = [
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        ];

        boot.kernelPackages = lib.mkOverride 900 pkgs.cachyosKernels.linuxPackages-cachyos-latest;
      };
  };
}
