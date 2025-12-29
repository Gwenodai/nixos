{
  flake.modules.nixos.gwen-t1 = {
    modulesPath,
    ...
  }:
  
  {
    imports =[
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot.initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "sr_mod"
      "virtio_blk"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    networking.useDHCP = true;

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}