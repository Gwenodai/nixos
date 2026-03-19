{ den, ... }: {
  den.aspects.gwen = {
    includes = with den.aspects; [
      # Adds `wheel` and `networkmanager` groups
      den._.primary-user
      ( den._.user-shell lib.mkDefault "zsh" )
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
