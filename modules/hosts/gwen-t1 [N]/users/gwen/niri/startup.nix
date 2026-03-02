{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    config,
    pkgs,
    lib,
    ...
  }: {
    config = lib.mkIf ( config.programs.niri.enable or false ) {
      # --- HOME MANAGER MODULE ---
      home-manager.users.gwen = {
        ...
      }: {
        programs.niri.settings.spawn-at-startup = [
          { sh = "${(lib.getExe pkgs.vesktop)} --start-minimized"; }
        ];
      };
    };
  };
}
