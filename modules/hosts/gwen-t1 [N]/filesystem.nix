{
  flake.modules.nixos.gwen-t1 = {
    fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "mode=755"
        "noatime"
      ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/9888-1FC4";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
        "noatime"
      ];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/dc948fcc-fbb8-44a7-b55e-6d0c13cb6382";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };

    fileSystems."/var/log" = {
      device = "/dev/disk/by-uuid/dc948fcc-fbb8-44a7-b55e-6d0c13cb6382";
      fsType = "btrfs";
      options = [
        "subvol=log"
        "compress=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    fileSystems."/persist" = {
      device = "/dev/disk/by-uuid/dc948fcc-fbb8-44a7-b55e-6d0c13cb6382";
      fsType = "btrfs";
      options = [
        "subvol=persist"
        "compress=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    fileSystems."/persist/home" = {
      device = "/dev/disk/by-uuid/dc948fcc-fbb8-44a7-b55e-6d0c13cb6382";
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
        "noatime"
      ];
    };

    swapDevices = [ ];
  };
}