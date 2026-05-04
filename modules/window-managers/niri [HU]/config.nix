{ den, ... }:
{
  den.aspects.niri._.config = den.lib.perUser {
    homeManager =
      {
        config,
        pkgs,
        lib,
        ...
      }:
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
        programs.niri = {
          package = lib.mkDefault pkgs.niri;

          settings = {
            xwayland-satellite = {
              enable = lib.mkDefault true;
              path = lib.mkDefault "${lib.getExe pkgs.xwayland-satellite}";
            };

            spawn-at-startup = [ { command = [ "${delayedStartup}" ]; } ];
          };
        };

        xdg.portal.config.niri = {
          default = lib.mkDefault [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = lib.mkDefault [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = lib.mkDefault [ "gnome" ];
          "org.freedesktop.impl.portal.FileChooser" = lib.mkDefault [ "gtk" ];
        };
      };
  };
}
