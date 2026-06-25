{ den, self, ... }:
{
  den.aspects.stacy = {
    includes = [
      den.batteries.host-aspects
      den.batteries.primary-user
    ];

    nixos = {
      sops.secrets = {
        stacy-password = {
          sopsFile = "${self}/secrets/stacy.yaml";
          key = "user-password";
          neededForUsers = true;
        };
      };
    };

    user =
      { config, ... }:
      {
        hashedPasswordFile = config.sops.secrets.stacy-password.path;
      };
  };
}
