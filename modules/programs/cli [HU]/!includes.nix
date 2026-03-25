{ den, ... }: {
  den.aspects.cli = {
    # All sub-aspects are included when the generic 'cli' aspect is used
    includes = with den.aspects.cli._; [
      tools
      bat
      btop
      direnv
      eza
      nh
    ];
  };
}