{ den, ... }:
{
  den.aspects.gwen = {
    includes = [
      den.batteries.host-aspects
    ];

    nixos =
      { config, ... }:
      {
        sops.secrets = {
          user-password.neededForUsers = true;
          "git/access-tokens/nixos-flake-updates" = { };
        };

        nix.extraOptions = ''
          !include ${config.sops.secrets."git/access-tokens/nixos-flake-updates".path}
        '';
      };

    user =
      { config, ... }:
      {
        hashedPasswordFile = config.sops.secrets.user-password.path;
      };
  };
}
