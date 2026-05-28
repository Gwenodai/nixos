{ den, ... }:
let
  nh = {
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
            extraArgs = "--keep-since 30d --keep 3";
          };
        };
      };
  };
in
{
  den.aspects.cli.includes = [
    nh
  ];
}
