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
        nix.settings.substituters = [ "https://cache.lantian.pub/lantian" ];
        nix.settings.trusted-public-keys = [
          "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
        ];

        boot.kernelPackages = lib.mkOverride 900 pkgs.cachyosKernels.linuxPackages-cachyos-latest;
      };
  };
}
