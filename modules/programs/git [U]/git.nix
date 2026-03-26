{ den, lib, ... }: {
  den.aspects.git = {
    # All sub-aspects are included when the generic 'git' aspect is used
    includes = lib.attrValues den.aspects.git._;
    
    _.git = {
      # Bundles all git components when the complete 'git' sub-aspect is used
      includes = lib.attrValues den.aspects.git._.git._;

      enable = den.lib.perUser {
        homeManager = { lib, ... }: {
          programs.git = {
            enable = lib.mkDefault true;
            settings = {
              init.defaultBranch = lib.mkDefault  "main";
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
