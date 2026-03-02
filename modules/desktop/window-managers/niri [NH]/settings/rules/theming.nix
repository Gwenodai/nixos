{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.niri = {
    ...
  }: {
    programs.niri.settings = {
      window-rules = [
        { # Rounded corners
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
        { # Shadow behind windows
          matches = [
            { app-id = "^kitty$"; }
          ];
          shadow = {
            draw-behind-window = true;
            color = "#000000B3";
          };
        }
      ];
    };
  };
}
