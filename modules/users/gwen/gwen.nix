{
  den,
  ...
}: {
  # user aspect
  den.aspects.gwen = {
    includes = [
      # Adds `wheel` and `networkmanager` groups
      den.provides.primary-user
    ];

    # TODO: Might be outdated. Check for user class battery
    nixos = {
      users.users.gwen = {
        initialPassword = "changeme";
      };
    };

    # User provides config to the host
    # provides.gwen-t1 = {
    #   host,
    #   ...
    # }: {
    #   nixos.programs.nh.enable = true;
    # };
  };
}
