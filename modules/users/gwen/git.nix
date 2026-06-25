{ self, ... }: {
  den.aspects.gwen = {
    homeManager =
      { config, ... }:
      {
        sops = {
          # Initialise secrets
          secrets = {
            email.sopsFile = "${self}/secrets/gwen.yaml";
            "ssh-keys/git_private" = {
              sopsFile = "${self}/secrets/gwen.yaml";
              mode = "0600";
              path = "${config.home.homeDirectory}/.ssh/gwenodai@github";
            };
            "ssh-keys/git_public" = {
              sopsFile = "${self}/secrets/gwen.yaml";
              mode = "0644";
              path = "${config.home.homeDirectory}/.ssh/gwenodai@github.pub";
            };
          };
          # Construct git `user` config from secrets
          templates."git-credentials" = {
            content = ''
              [user]
                name = Gwen
                email = ${config.sops.placeholder.email}
            '';
          };
        };

        programs.git = {
          includes = [
            { path = config.sops.templates."git-credentials".path; }
          ];
          signing = {
            format = "ssh";
            key = config.sops.secrets."ssh-keys/git_public".path;
            signByDefault = true; # Automatically sign all commits
          };
        };

        # Assign the ssh key to github
        programs.ssh = {
          settings."github.com" = {
            user = "git";
            identityFile = config.sops.secrets."ssh-keys/git_private".path;
            identitiesOnly = true;
          };
        };
      };
  };
}
