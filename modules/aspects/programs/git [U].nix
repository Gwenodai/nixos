{ den, ... }:
let
  git = den.lib.perUser {
    homeManager = {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
        };
      };
    };
  };

  gh = den.lib.perUser {
    homeManager = {
      programs.gh = {
        enable = true;
        gitCredentialHelper = {
          enable = true;
        };
      };
    };
  };
in
{
  den.aspects.git.includes = [
    git
    # gh
  ];
}
