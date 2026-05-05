{ den, ... }:
{
  den.aspects.noctalia._.plugins = {
    includes = with den.aspects.noctalia._.plugins._; [
      config
      keybind-cheatsheet
      polkit
    ];
  };
}
