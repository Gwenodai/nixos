{ den, ... }: {
  den.aspects.terminal = {
    includes = with den.aspects.shells.provides; [
      zsh
      bash
      starship
    ];
  };
}