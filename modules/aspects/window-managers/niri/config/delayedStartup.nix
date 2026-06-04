{
  den.aspects.niri = {
    homeManager =
      { config, pkgs, ... }:
      let
        # Custom script to startup certain apps after a delay
        # to allow for the system tray to load first
        delayedStartup = pkgs.writeShellScript "delayed-startup" ''
          # syntax: bash
          ${pkgs.coreutils}/bin/sleep 5
          for file in ${config.xdg.configHome}/autostart/*.desktop; do
            if ${pkgs.gnugrep}/bin/grep -q "NotShowIn=.*niri" "$file"; then
              ${pkgs.dex}/bin/dex "$file"
            fi
          done
        '';
      in
      {
        programs.niri.settings.spawn-at-startup = [ { command = [ "${delayedStartup}" ]; } ];
      };
  };
}
