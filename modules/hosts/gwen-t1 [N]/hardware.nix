# Host hardware config
{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    modulesPath,
    config,
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
          "sd_mod"
          "usbhid"
          "xhci_pci"
          "usb_storage"
          "thunderbolt"
        ];
        systemd.enable = true;
        kernelModules = [ ];
      };
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    networking.useDHCP = true;

    hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}