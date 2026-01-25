{
  flake.modules.homeManager.swww = { pkgs, ... }: {
    # Using swww (Solution to your Wayland Wallpaper Woes) as requested (interpreted "awww" as swww).
    home.packages = [ pkgs.swww ];

    systemd.user.services.swww = {
      Unit = {
        Description = "Wayland wallpaper daemon";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
