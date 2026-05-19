let
  git-config = {
    homeManager =
      { config, ... }:
      {
        sops = {
          # Initialise secrets
          secrets = {
            "git/email" = { };
            "git/ssh-key/private" = {
              mode = "0600";
              path = "${config.home.homeDirectory}/.ssh/gwenodai@github";
            };
            "git/ssh-key/public" = {
              mode = "0644";
              path = "${config.home.homeDirectory}/.ssh/gwenodai@github.pub";
            };
          };
          # Construct git `user` config from secrets
          templates."git-credentials" = {
            content = ''
              [user]
                name = Gwen
                email = ${config.sops.placeholder."git/email"}
            '';
          };
        };

        programs.git = {
          includes = [
            { path = config.sops.templates."git-credentials".path; }
          ];
          signing = {
            format = "ssh";
            key = config.sops.secrets."git/ssh-key/public".path;
            signByDefault = true; # Automatically sign all commits
          };
        };

        # Assign the ssh key to github
        programs.ssh = {
          matchBlocks."github.com" = {
            host = "github.com";
            user = "git";
            identityFile = config.sops.secrets."git/ssh-key/private".path;
            identitiesOnly = true;
          };
        };
      };
  };
in
{
  den.aspects.gwen.includes = [ git-config ];
}
