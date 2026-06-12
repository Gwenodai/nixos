{
  den.aspects.stacy-pc = {
    nixos =
      { pkgs, config, ... }:
      {
        #---Boot Config---#
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

          kernelModules = [
            # Kernel-based Virtual Machine support
            "kvm-amd"
            # Driver for MB fan control
            "nct6687"
          ];
          # Driver for MB fan control
          extraModulePackages = [ config.boot.kernelPackages.nct6687d ];
        };
      };
  };
}
