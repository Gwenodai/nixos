{ den, ... }:
let
  git = {
    homeManager = {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
        };
      };
    };
  };

  gh = {
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
