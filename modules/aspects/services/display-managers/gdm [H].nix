{ den, ... }:
{
  den.aspects.gdm = den.lib.perHost {
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

    persist.directories = [
      "/var/lib/gdm"
    ];
  };
}
