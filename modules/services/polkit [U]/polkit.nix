{ den, ... }: {
  den.aspects.polkit = {
    includes = with den.aspects.polkit._; [ polkit-gnome ];

    _.polkit-gnome = den.lib.perUser {
      nixos = { lib, ... }: {
        security.polkit.enable = lib.mkDefault true;
      };

      homeManager = { config, pkgs, lib, ... }: {
        services.polkit-gnome.enable = lib.mkDefault true;

        systemd.user.services = lib.mkIf config.services.polkit-gnome.enable {
          polkit-gnome-authentication-agent-1 = lib.mkDefault {
            Unit = {
              Description = "polkit-gnome-authentication-agent-1";
              Wants = [ "graphical-session.target" ];
              After = [ "graphical-session.target" ];
            };
            Install = {
              WantedBy = [ "graphical-session.target" ];
            };
            Service = {
              Type = "simple";
              ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
              Restart = "on-failure";
              RestartSec = 1;
              TimeoutStopSec = 10;
            };
          };
        };
      };
    };
  };
}
