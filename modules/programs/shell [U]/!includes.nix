{ den, ... }: {
  den.aspects.terminal.includes = with den.aspects.shells._; [
    zsh
    bash
    starship
  ];
}