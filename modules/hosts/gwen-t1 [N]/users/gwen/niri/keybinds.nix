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
        lib,
        ...
      }: {
        programs.niri.settings.binds = with config.lib.niri.actions;
          let
            # Makeshift `spawn-sh` functionality
            sh = spawn "sh" "-c";
            # Spawn a single package's executable
            spawnPkg = pkg: spawn (lib.getExe pkg);
            # Spawn an executable wrapped in Kitty
            spawnTermPkg = pkg: spawnPkg pkgs.kitty (lib.getExe pkg);
          in
        lib.attrsets.mergeAttrsList [
          {
            # "Mod+R".action             = RUNNER;
            "Mod+T".action             = spawnPkg     pkgs.kitty;
            "Mod+E".action             = spawnPkg     pkgs.nemo;
            "Mod+G".action             = spawnPkg     pkgs.google-chrome;
            "Ctrl+Shift+Escape".action = spawnTermPkg pkgs.btop;
            "MoD+Shift+P".action       = power-off-monitors;
            "Mod+Ctrl+Shift+Q".action  = sh "pkill -9 winedevice.exe";
            # "MoD+Shift+C".action       = CLIPBOARD;
          }
        ];
      };
    };
  };
}
