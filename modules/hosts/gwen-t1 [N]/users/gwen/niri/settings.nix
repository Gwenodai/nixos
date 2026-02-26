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
        programs.niri = {
          settings = {
            debug = {
              skip-cursor-only-updates-during-vrr = [];
            };
          };
          
          # Stupid extension... Rust highlighting is close enough to make kdl readable
          extraConfig = builtins.replaceStrings ["// syntax: rust\n"] [""] ''
            // syntax: rust
            recent-windows {
              highlight {
                padding 10
                corner-radius 20
              }

              binds {
                Alt+Tab         { next-window; }
                Alt+Shift+Tab   { previous-window; }
                Alt+grave       { next-window     filter="app-id"; }
                Alt+Shift+grave { previous-window filter="app-id"; }
              }
            }
          '';
        };
      };
    };
  };
}
