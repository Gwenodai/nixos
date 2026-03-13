{ den, ... }: {
  den.aspects.cli = {
    includes = with den.aspects.cli.provides; [ direnv ];
    
    provides.direnv = {
      homeManager = { lib, ... }: {
        programs.direnv = {
          enable = lib.mkDefault true;
          nix-direnv.enable = lib.mkDefault true;
        };
      };
      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.dataHome}/direnv/allow";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };
      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                   # "~/.local"
        "${hmConfig.xdg.dataHome}" = {}; # "~/.local/share"
        "${hmConfig.xdg.dataHome}/direnv" = {};
      };
    };
  };
}
