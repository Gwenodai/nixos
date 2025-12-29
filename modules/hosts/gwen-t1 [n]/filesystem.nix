{
  flake.modules.nixos.gwen-t1 = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/5da1f4de-e96f-4bfb-8068-16c2d5f8cc52";
      fsType = "ext4";
    };

    swapDevices = [ ];
  };
}