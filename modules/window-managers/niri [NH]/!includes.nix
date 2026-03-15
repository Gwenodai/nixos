{ den, ... }: {
  den.aspects.niri = {
    includes = with den.aspects.niri._; [
      enable
      settings
      input
      environment
      keybinds
      rules
      class
    ];
  };
}