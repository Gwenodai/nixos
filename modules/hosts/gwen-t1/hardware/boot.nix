# Host boot config
{
  den.aspects.gwen-t1 = {
    nixos = {
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
          kernelModules = [];
        };
        kernelModules = [
          "kvm-amd" # Kernel-based Virtual Machine support
        ];
        extraModulePackages = [];
      };
    };
  };
}