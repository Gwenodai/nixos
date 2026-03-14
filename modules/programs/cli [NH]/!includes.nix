{ den, ... }: {
  den.aspects.cli = {
    includes = with den.aspects.cli._; [
      archive-tools
      cli-tools
      sys-tools
      bat
      btop
      direnv
      eza
      nh
    ];
  };
}