{ den, ... }:
{
  den.aspects.noctalia._.niri._.startup = den.lib.perUser {
    niri =
      { lib, config, ... }:
      {
        settings.spawn-at-startup = [
          { command = [ "${lib.getExe config.programs.noctalia-shell.package}" ]; }
        ];
      };
  };
}
