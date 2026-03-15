{ den, ... }: {
  # user aspect
  den.aspects.gwen = {
    includes = [
      # Adds `wheel` and `networkmanager` groups
      den.provides.primary-user
    ];

    nixos = { config, ... }: {
      sops.secrets = {
        user-password.neededForUsers = true;
        "git/access-tokens/nixos-flake-updates" = {};
      };

      nix.extraOptions = ''
        !include ${config.sops.secrets."git/access-tokens/nixos-flake-updates".path}
      '';
    };

    user = { config, ... }: {
      hashedPasswordFile = config.sops.secrets.user-password.path;
    };
  };
}
