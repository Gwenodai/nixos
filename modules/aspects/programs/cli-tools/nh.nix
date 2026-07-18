{ den, ... }: {
  den.aspects.nh = {
    homeManager =
      { config, ... }:
      {
        programs.nh = {
          enable = true;
          flake = "${config.home.homeDirectory}/dots";
          osFlake = "${config.home.homeDirectory}/dots";
          homeFlake = "${config.home.homeDirectory}/dots";

          clean = {
            enable = true;
            dates = "weekly";
            extraArgs = "--keep-since 30d --keep 5 --optimise --no-gc";
          };
        };
      };
  };
  den.aspects.cli-tools.includes = [ den.aspects.nh ];
}
