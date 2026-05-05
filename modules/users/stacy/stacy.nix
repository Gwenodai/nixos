{
  den.aspects.stacy = {
    nixos = {
      sops.secrets = {
        user-password.neededForUsers = true;
      };
    };

    user =
      { config, ... }:
      {
        hashedPasswordFile = config.sops.secrets.user-password.path;
      };
  };
}
