# Host system config
{
  den,
  ...
}: {
  den.aspects.gwen-t1 = {
    includes = [
      den.aspects.persist
    ];

    # Host provides config to the user
    # provides.gwen = {
    #   user,
    #   ...
    # }: {
    #   nixos.programs.nh.enable = true;
    # };
  };
}