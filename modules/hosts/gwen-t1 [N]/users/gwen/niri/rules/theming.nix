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
        programs.niri.settings = {
          window-rules = [
            { # Shadow behind windows
              matches = [
                { app-id = "^kitty$"; }
              ];
              shadow = {
                draw-behind-window = true;
                color = "#000000B3";
              };
            }
            { # 90% Transparent windows + Shadow behind
              matches = [
                { is-floating = true; }
                { app-id = "^vesktop$"; }
              ];
              opacity = 0.9;
              draw-border-with-background = false;
              shadow = {
                draw-behind-window = true;
                color = "#000000B3";
              };
            }
            { # 80% Transparent windows + Shadow behind
              matches = [
                { is-floating = true; }
                { app-id = "^nemo$"; }
              ];
              opacity = 0.8;
              draw-border-with-background = false;
              shadow = {
                draw-behind-window = true;
                color = "#000000B3";
              };
            }
          ];

          # layer-rules = [
          #   { # Shadow behind layers
          #     matches = [
          #       { namespace = "^rofi$"; }
          #     ];
          #     shadow = {
          #       draw-behind-window = true;
          #       color = "#000000B3";
          #       enable = true;
          #     };
          #   }
          #   { # Render walpaper in backdrop for overview mode
          #     matches = [ { namespace = "^swww-daemon$"; } ];
          #     place-within-backdrop = true;
          #   }
          # ];
        };
      };
    };
  };
}
