{ den, ... }:
let
  startup = den.lib.perUser {
    niri =
      { lib, config, ... }:
      {
        settings.spawn-at-startup = [
          { command = [ "${lib.getExe config.programs.noctalia-shell.package}" ]; }
        ];
      };
  };
in
{
  den.aspects.noctalia._.config.includes = [
    startup
  ];
}
