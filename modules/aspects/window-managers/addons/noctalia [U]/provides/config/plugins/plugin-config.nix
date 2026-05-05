{ den, ... }:
let
  config = den.lib.perUser {
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
