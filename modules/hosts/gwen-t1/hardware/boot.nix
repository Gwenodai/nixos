# Host boot config
{
  den.aspects.gwen-t1 = {
    nixos =
      { pkgs, ... }:
      {
        boot = {
          initrd.availableKernelModules = [
            "nvme"
            "ahci"
            "usbhid"
            "xhci_pci"
            "usb_storage"
            "thunderbolt"
          ];

          # Latest CachyOS kernel with Zen4/5 specific optimizations
          kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;

          kernelModules = [ "kvm-amd" ]; # Kernel-based Virtual Machine support
        };
      };
  };
}
