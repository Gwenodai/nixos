{ den, ... }: {
  den.aspects.xdg = {
    includes = with den.aspects.xdg._; [
      enable
      persist
    ];
  };
}