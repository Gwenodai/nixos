# Host hardware config
{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    modulesPath,
    pkgs,
    ...
  }: {
    imports =[
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    
    boot = {
      initrd = {
        availableKernelModules = [
          "nvme"
          "ahci"
          "usbhid"
          "xhci_pci"
          "usb_storage"
          "thunderbolt"
        ];
        kernelModules = [ ];
      };
      kernelModules = [
        "kvm-amd" # Kernel-based Virtual Machine support
      ];
      extraModulePackages = [ ];

      kernelParams = [
        "preempt=full"
        "split_lock_detect=off"
      ];
      
      # Latest CachyOS kernel with Zen4/5 specific optimizations
      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
    };

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}