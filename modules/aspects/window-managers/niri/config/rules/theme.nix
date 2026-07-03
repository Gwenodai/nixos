{
  den.aspects.niri = {
    homeManager = {
      programs.niri.settings = {
        window-rules = [
          ### Rounded corners
          {
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
          ### Shadow behind windows
          {
            matches = [
              ## Kitty terminal
              { app-id = "^kitty$"; }
            ];
            shadow = {
              draw-behind-window = true;
              color = "#000000B3";
            };
          }
          ### 90% Transparent windows + Shadow behind
          {
            matches = [
              ## Vesktop
              { app-id = "^vesktop$"; }
              ## Noctalia Settings window
              # { app-id = "dev.noctalia.Noctalia.Settings"; }
            ];
            opacity = 0.9;
            draw-border-with-background = false;
            shadow = {
              draw-behind-window = true;
              color = "#000000B3";
            };
          }
          ### 80% Transparent windows + Shadow behind
          {
            matches = [
              ## Any floating window
              { is-floating = true; }
              ## Nemo file manager
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
