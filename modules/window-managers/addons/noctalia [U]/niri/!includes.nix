{ den, ... }:
{
  den.aspects.noctalia._.niri = {
    includes = with den.aspects.noctalia._.niri._; [
      keybinds
      rules
      startup
    ];
  };
}
