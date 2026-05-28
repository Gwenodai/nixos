{ inputs, den, ... }:
let
  # Regular NixOS kernel
  default = {
    nixos =
      { pkgs, lib, ... }:
      {
        boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      };
  };

  # CachyOS kernel for NixOS
  cachyos = {
    nixos =
      { pkgs, lib, ... }:
      {
        nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
        nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
        nix.settings.trusted-public-keys = [
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        ];

        boot.kernelPackages = lib.mkOverride 900 pkgs.cachyosKernels.linuxPackages-cachyos-latest;

        # Swap ananicy rules to cachyos rules in case ananicy is enabled
        services.ananicy.rulesProvider = pkgs.ananicy-rules-cachyos;
      };
  };
in
{
  # Flake inputs
  flake-file.inputs = {
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  den.aspects.kernel.includes = [ default ];
  den.aspects.kernel._.cachyos.includes = [ cachyos ];
}
