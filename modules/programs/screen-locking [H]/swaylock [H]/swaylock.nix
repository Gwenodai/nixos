{
  flake.modules.homeManager.swaylock = { pkgs, ... }: {
    programs.swaylock = {
      enable = true;
      settings = {
        color = "000000";
        show-failed-attempts = true;
      };
    };

    services.swayidle = {
      enable = true;
      events = [
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
        { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      ];
      timeouts = [
        { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f"; }
        { timeout = 600; command = "niri msg action power-off-monitors"; resumeCommand = "niri msg action power-on-monitors"; }
      ];
    };
  };
}
