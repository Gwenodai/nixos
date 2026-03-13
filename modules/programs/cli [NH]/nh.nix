{ den, ... }: {
  den.aspects.cli = {
    includes = with den.aspects.cli.provides; [ nh ];

    provides.nh = {
      homeManager = { config, lib, ... }: {
        programs.nh = {
          enable = lib.mkDefault true;
          clean = {
            enable = lib.mkDefault true;
            extraArgs = lib.mkDefault "--keep-since 30d --keep 3";
          };
          flake = lib.mkDefault "${config.home.homeDirectory}/dots";
          osFlake = lib.mkDefault "${config.home.homeDirectory}/dots";
          homeFlake = lib.mkDefault "${config.home.homeDirectory}/dots";
        };
      };
    };
  };
}
