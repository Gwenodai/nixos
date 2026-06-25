{ den, self, ... }:
{
  den.aspects.gwen = {
    includes = [
      den.batteries.host-aspects
      den.batteries.primary-user
    ];

    nixos =
      { config, ... }:
      {
        sops.secrets = {
          gwen-password = {
            sopsFile = "${self}/secrets/gwen.yaml";
            key = "user-password";
            neededForUsers = true;
          };
          flake-update-token = {
            sopsFile = "${self}/secrets/gwen.yaml";
          };
        };

        nix.extraOptions = ''
          !include ${config.sops.secrets.flake-update-token.path}
        '';
      };

    user =
      { config, ... }:
      {
        hashedPasswordFile = config.sops.secrets.gwen-password.path;
      };
  };
}
