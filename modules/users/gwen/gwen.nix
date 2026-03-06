{
  den,
  ...
}: {
  # user aspect
  den.aspects.gwen = {
    includes = [
      den.provides.primary-user
      ( den.provides.user-shell "zsh" )
    ];

    nixos = {
      users.users.gwen = {
        initialPassword = "changeme";
      };
    };

    # User provides config to the host
    provides.gwen-t1 = {
      host,
      ...
    }: {
      # nixos.programs.nh.enable = host.name == "gwen-t1";
      # OR
      nixos.programs.nh.enable = true;
    };
  };
}
