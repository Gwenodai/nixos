{
  den.aspects.ymir = {
    #---Filesystem Config---#
    nixos = { lib, ... }: {
      # FIXME: Temp stub
      fileSystems."/" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = [
          "defaults"
          "size=4G"
          "mode=755"
        ];
      };
    };
  };
}
