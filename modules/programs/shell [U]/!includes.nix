{ den, ... }: {
  den.aspects.shell.includes = with den.aspects.shell._; [
    zsh
    bash
    starship
  ];
}