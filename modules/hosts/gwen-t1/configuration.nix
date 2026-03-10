# Host system config
{
  den,
  ...
}: {
  den.aspects.gwen-t1 = {
    includes = [
      den.aspects.persist
    ];
    
    persist = {
      directories = [
        "/var/log"
        "/var/lib/nixos"
      ];
      files = [
        "/etc/machine-id"
      ];
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