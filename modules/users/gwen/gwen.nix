{
  den,
  ...
}: {
  # user aspect
  den.aspects.gwen = {
    includes = [
      den.provides.primary-user
      (den.provides.user-shell "zsh")
    ];

    # nixos = {
    #   users.users.gwen = {
    #     initialPassword = "changeme";
    #   };
    # };
  };
}
