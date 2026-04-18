# Host boot config
{
  den.aspects.stacy-pc = {
    nixos = { pkgs, config, ... }: {
      boot = {
        initrd.availableKernelModules = [
          "nvme"
          "ahci"
          "sd_mod"
          "usbhid"
          "xhci_pci"
          "usb_storage"
          "thunderbolt"
        ];
        
        # Latest CachyOS kernel with Zen4/5 specific optimizations
        kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;

        kernelModules = [
          "kvm-amd" # Kernel-based Virtual Machine support
          "nct6687" # Driver for MB fan control
        ];
        extraModulePackages = [ config.boot.kernelPackages.nct6687d ];
      };
    };
  };
}