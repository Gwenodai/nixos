{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.polkit = {
    lib,
    ...
  }: {
    security.polkit.enable = lib.mkDefault true;
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.polkit = {
    config,
    pkgs,
    lib,
    ...
  }: {
    services.polkit-gnome = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.polkit_gnome;
    };

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
}