{ den, ... }:
{
  den.aspects.stacy = {
    includes = [ den.batteries.host-aspects ];

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
