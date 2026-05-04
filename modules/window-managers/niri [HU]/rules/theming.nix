{ den, ... }:
{
  den.aspects.niri._.rules._.theming = den.lib.perUser {
    homeManager = {
      programs.niri.settings = {
        window-rules = [
          {
            # Rounded corners
            geometry-corner-radius =
              let
                radius = 18.0;
              in
              {
                top-left = radius;
                top-right = radius;
                bottom-left = radius;
                bottom-right = radius;
              };
            clip-to-geometry = true;
          }
          {
            # Shadow behind windows
            matches = [
              { app-id = "^kitty$"; }
            ];
            shadow = {
              draw-behind-window = true;
              color = "#000000B3";
            };
          }
          {
            # 90% Transparent windows + Shadow behind
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
          {
            # 80% Transparent windows + Shadow behind
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
      };
    };
  };
}
