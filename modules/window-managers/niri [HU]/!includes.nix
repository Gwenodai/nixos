{ den, ... }:
{
  den.aspects.niri = {
    includes = with den.aspects.niri._; [
      enable
      class
      settings
      rules
      config
    ];
  };
}
