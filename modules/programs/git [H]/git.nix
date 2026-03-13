{ den, ... }: {
  den.aspects.git = {
    includes = with den.aspects.git.provides; [
      git
      gh
    ];
    
    provides.git = {
      homeManager = { lib, ... }: {
        programs.git = {
          enable = lib.mkDefault true;
          settings = {
            init.defaultBranch = lib.mkDefault  "main";
          };
        };
      };
    };

    provides.gh = {
      homeManager = { lib, ... }: {
        programs.gh = {
          enable = lib.mkDefault true;
          gitCredentialHelper = {
            enable = lib.mkDefault true;
          };
        };
      };
    };
  };
}
