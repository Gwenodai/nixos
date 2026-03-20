{ den, ... }: {
  den.aspects.noctalia = {
    includes = with den.aspects.noctalia._; [
      enable
      class
      settings
      plugins
      colour-schemes
      niri
    ];
  };
}