# Host system config
{
  ...
}: {
  den.aspects.gwen-t1 = {
    includes = [
      # gwen.hostname
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