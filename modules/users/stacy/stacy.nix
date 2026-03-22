{ ... }: {
  den.aspects.stacy = {
    user = { config, ... }: {
      initialPassword = "changeme";
      # hashedPasswordFile = config.sops.secrets.user-password.path;
    };
  };
}
