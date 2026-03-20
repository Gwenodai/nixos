{ den, ... }: {
  den.aspects.noctalia._.niri._.startup = den.lib.perUser {
    niri.settings.spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
    ];
  };
}