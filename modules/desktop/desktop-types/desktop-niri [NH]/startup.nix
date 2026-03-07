{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    config,
    lib,
    ...
  }: {
    config = lib.mkIf ( config.programs.niri.enable or false ) {
      # --- HOME MANAGER MODULE ---
      home-manager.users.gwen = {
        config,
        pkgs,
        ...
      }: let
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
      in {
        programs.niri.settings.spawn-at-startup = [
          { command = ["${delayedStartup}"]; }
        ];
      };
    };
  };
}
