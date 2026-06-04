{
  den.aspects.gdm = {
    nixos = {
      services.displayManager = {
        enable = true;
        gdm = {
          enable = true;
          wayland = true;
          autoSuspend = true;
        };
      };
    };

    ### Persist config
    persist = {
      directories = [
        "/var/lib/gdm"
      ];
    };
  };
}
