# Host system config
{
  den,
  lib,
  ...
}: {
  den.aspects.gwen-t1 = {
    includes = [
      # den.aspects.persist
    ];

    nixos = {
      # FIXME: Boot config is temporary
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