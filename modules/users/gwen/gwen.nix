{ den, ... }: {
  # user aspect
  den.aspects.gwen = {
    includes = [
      # Adds `wheel` and `networkmanager` groups
      den.provides.primary-user
    ];

    # Forwards to `nixos.users.users.<username>`
    user.initialPassword = "changeme";
    # user.hashedPasswordFile = "";
  };
}
