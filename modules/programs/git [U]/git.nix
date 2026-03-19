{ den, ... }: {
  den.aspects.git = {
    includes = with den.aspects.git._; [ git gh ];
    
    _.git = den.lib.perUser {
      homeManager = { lib, ... }: {
        programs.git = {
          enable = lib.mkDefault true;
          settings = {
            init.defaultBranch = lib.mkDefault  "main";
          };
        };
      };
    };

    _.gh = den.lib.perUser {
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
