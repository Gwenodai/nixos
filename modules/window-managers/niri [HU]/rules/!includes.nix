{ den, ... }:
{
  den.aspects.niri._.rules.includes = with den.aspects.niri._.rules._; [
    general
    screencast
    theming
    vrr
  ];
}
