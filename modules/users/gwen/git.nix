{ den, ... }: {
  den.aspects.gwen = {
    homeManager = { config, ... }: {
      sops = {
        # Initialise secrets
        secrets = {
          "git/name" = {};
          "git/email" = {};
        };
        # Construct git `user` config from secrets
        templates."git-credentials" = {
          content = ''
            [user]
              name = "${config.sops.placeholder."git/name"}"
              email = "${config.sops.placeholder."git/email"}"
          '';
        };
      };
    };

    git = { config, ... }: {
      includes = [
        { path = config.sops.templates."git-credentials".path; }
      ];
    };
  };
}
