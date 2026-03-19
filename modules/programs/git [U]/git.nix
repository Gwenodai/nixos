{ den, lib, ... }: {
  den.aspects.git = {
    includes = with den.aspects.git._; [
      git
      gh
      class
    ];
    
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

    _.class = den.lib.perUser (
      { class, aspect-chain }: den._.forward {
        each = lib.singleton true;
        fromClass = _: "git";
        intoClass = _: "homeManager";
        intoPath = _: [ "programs" "git" ];
        fromAspect = _: lib.head aspect-chain;
        adaptArgs = lib.id;
        guard = { config, ... }@hmArgs: _: lib.mkIf config.programs.git.enable;
      }
    );
  };
}
