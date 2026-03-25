{ den, ... }: {
  den.aspects.cli._.tools = {
    includes = with den.aspects.cli._.tools._; [
      archive-tools
      cli-tools
      sys-tools
    ];
  };
}