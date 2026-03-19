{ den, ... }: {
  den.aspects.noctalia = {
    includes = with den.aspects.noctalia._; [
      enable
      settings
      niri
    ];
  };
}