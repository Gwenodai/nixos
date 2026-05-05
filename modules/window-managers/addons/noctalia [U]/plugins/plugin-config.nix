{ den, ... }:
{
  den.aspects.noctalia._.plugins._.config = den.lib.perUser {
    homeManager =
      { lib, ... }:
      {
        programs.noctalia-shell = {
          plugins.version = lib.mkDefault 2;
        };
      };
  };
}
