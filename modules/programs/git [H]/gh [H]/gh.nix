{
  flake.modules.homeManager.git = { ... }:

  {
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
  };
}