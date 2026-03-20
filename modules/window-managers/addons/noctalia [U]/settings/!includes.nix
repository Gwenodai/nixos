{ den, ... }: {
  den.aspects.noctalia._.settings = {
    includes = with den.aspects.noctalia._.settings._; [
      app-launcher
      bar
      dock
      general
      idle
      notifications
      session-menu
      system
      ui
      wallpaper
    ];
  };
}