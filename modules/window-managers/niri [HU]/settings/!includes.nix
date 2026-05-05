{ den, ... }:
{
  den.aspects.niri._.settings = {
    includes = with den.aspects.niri._.settings._; [
      environment
      input
      keybinds
      main
    ];
  };
}
