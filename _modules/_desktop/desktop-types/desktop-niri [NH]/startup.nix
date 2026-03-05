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
      }: let
        delay = cmd: "${pkgs.coreutils}/bin/sleep 5 && ${cmd}";
      in {
        programs.niri.settings.spawn-at-startup = [
          { sh = delay "${lib.getExe pkgs.vesktop} --start-minimized"; }
          { sh = delay "${pkgs.caprine}/bin/caprine"; }
        ];
      };
    };
  };
}
