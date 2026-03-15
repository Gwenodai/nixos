{ den, ... }: {
  den.aspects.niri = {
    includes = with den.aspects.niri._.rules._; [
      general
      screencast
      theming
      vrr
    ];
  };
}