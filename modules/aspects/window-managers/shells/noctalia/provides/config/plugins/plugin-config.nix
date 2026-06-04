{ den, ... }:
let
  config = {
    homeManager = {
      programs.noctalia-shell = {
        plugins.version = 2;
      };
    };
  };
in
{
  den.aspects.noctalia._.config.includes = [
    config
  ];
}
