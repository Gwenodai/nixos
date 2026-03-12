# Host system config
{ den, ... }: {
  den.aspects.gwen-t1 = {
    includes = [
      den.aspects.persist
    ];

    # TODO: Below config is temporary
    homeManager = { lib, ... }: {
      xdg.enable = lib.mkDefault true;
    };
    nixos = { lib, ... }: {
      boot = {
        initrd = {
          systemd.enable = lib.mkDefault true;
        };

        loader = {
          systemd-boot.enable = lib.mkDefault true;
          efi.canTouchEfiVariables = lib.mkDefault true;
        };
      };
    };

    # Host provides config to the user
    # provides.gwen = {
    #   user,
    #   ...
    # }: {
    #   nixos.programs.nh.enable = true;
    # };
  };
}