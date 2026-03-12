# Host system config
{ self, den, ... }: {
  den.aspects.gwen-t1 = {
    includes = [
      den.aspects.persist
    ];
    
    nixos = { lib, ... }: {
      sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";

# TODO: Below config is temporary
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
    homeManager = { lib, ... }: {
      xdg.enable = lib.mkDefault true;
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