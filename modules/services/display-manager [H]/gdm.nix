{ den, ... }: {
  den.aspects.display-manager._.gdm = den.lib.perHost {
    nixos = { lib, ... }: {
      services.displayManager = {
        enable = lib.mkDefault true;
        gdm = {
          enable = lib.mkDefault true;
          wayland = lib.mkDefault true;
          autoSuspend = lib.mkDefault true;
        };
      };
    };

    persist.directories = [
      "/var/lib/gdm"
    ];
  };
}
