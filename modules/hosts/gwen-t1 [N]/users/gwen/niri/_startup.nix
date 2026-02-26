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
        ...
      }: {
        programs.niri.settings.spawn-at-startup = [
          # { sh = "sudo /run/current-system/sw/bin/wakeup-secondary-display"; }
        ];
      };
    };
  };
}
