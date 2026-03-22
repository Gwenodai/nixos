{ den, ... }: {
  den.aspects.steam.includes = with den.aspects.steam._; [
    enable
    game-persist
  ];
}
