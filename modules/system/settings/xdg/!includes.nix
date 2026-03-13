{ den, ... }: {
  den.aspects.xdg = {
    includes = with den.aspects.xdg.provides; [
      xdgConfig
      persist
    ];
  };
}