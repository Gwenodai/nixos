{ inputs, den, ... }: {
  # Flake inputs
  flake-file.inputs = {
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  den.aspects.kernel = {
    includes = [ den.aspects.kernel.provides.default ];
    # Regular NixOS kernel
    provides.default = den.lib.take.exactly ({ host }: {
      nixos = { pkgs, lib, ... }: {
        boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      };   
    });

    # CachyOS kernel for NixOS
    provides.cachyos = den.lib.take.exactly ({ host }: {
      nixos = { pkgs, lib, ... }: {
        nixpkgs.overlays = [
          inputs.nix-cachyos-kernel.overlays.pinned
        ];

        nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
        nix.settings.trusted-public-keys = [
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        ];
        
        boot.kernelPackages =
          lib.mkOverride 900 pkgs.cachyosKernels.linuxPackages-cachyos-latest;
      };
    });
  };
}