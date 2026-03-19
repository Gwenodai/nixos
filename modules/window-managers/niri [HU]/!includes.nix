{ den, ... }: {
  den.aspects.niri = {
    includes = with den.aspects.niri._; [
      enable
      settings
      niri-config
      input
      environment
      keybinds
      rules
      class
    ];
  };
}