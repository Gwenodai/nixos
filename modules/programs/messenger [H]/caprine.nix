{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.messenger = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [ pkgs.caprine ];

    # Autostart after login
    systemd.user.services.caprine = lib.mkDefault {
      Install.WantedBy = [ "graphical-session.target" ];
      
      Service = {
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 5"; # Delay for system tray
        ExecStart = "${pkgs.caprine}/bin/caprine";
        Restart = "on-failure";
        RestartSec = 3;
      };

      Unit = {
        Description = "Elegant Facebook Messenger desktop app";
        After = [ "graphical-session.target" ];
        X-SwitchMethod = "keep-old";
      };
    };
  };
}