{
  den.aspects.git = {
    homeManager = {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
        };
      };
    };
  };
}
