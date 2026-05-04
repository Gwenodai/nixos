{ den, ... }:
{
  den.aspects.noctalia._.settings._.plugin-config = den.lib.perUser {
    homeManager =
      { lib, ... }:
      {
        programs.noctalia-shell = {
          settings.plugins = {
            autoUpdate = lib.mkDefault false;
            notifyUpdates = lib.mkDefault false;
          };
        };
      };
  };
}
