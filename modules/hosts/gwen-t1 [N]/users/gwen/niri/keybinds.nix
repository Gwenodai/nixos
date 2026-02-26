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
            sh = spawn "sh" "-c";
            # A helper that applies the same action to a list of keys
            # bindMany = keys: action: lib.genAttrs keys (key: { inherit action; });
          in
        lib.attrsets.mergeAttrsList [
          {
            # "Mod+R".action             = RUNNER;
            "Mod+T".action             = spawn "${(lib.getExe pkgs.kitty)}";
            "Mod+E".action             = spawn "${(lib.getExe pkgs.nemo)}";
            "Mod+G".action             = spawn "${(lib.getExe pkgs.google-chrome)}";
            "Ctrl+Shift+Escape".action = spawn "${(lib.getExe pkgs.kitty)}" "btop";
            "MoD+Shift+P".action       = power-off-monitors;
            "Mod+Ctrl+Shift+Q".action  = sh "pkill -9 winedevice.exe";
            # "MoD+Shift+C".action       = CLIPBOARD;
          }
        ];
      };
    };
  };
}
