# Host boot config
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    pkgs,
    ...
  }: {
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
    };
  };
}