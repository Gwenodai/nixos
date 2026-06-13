{
  den.aspects.noctalia = {
    niri =
      { lib, config, ... }:
      {
        settings.spawn-at-startup = [
          { command = [ "${lib.getExe config.programs.noctalia-shell.package}" ]; }
        ];
      };
  };
}
