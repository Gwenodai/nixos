{ den, ... }: {
  den.aspects.noctalia._.plugins._.config = den.lib.perUser {
    homeManager = { lib, ... }: {
      programs.noctalia-shell = {
        plugins.version = lib.mkDefault 2;
        settings.plugins =  {
          autoUpdate = lib.mkDefault false;
          notifyUpdates = lib.mkDefault false;
        };
      };
    };
  };
}