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
              radius = 20.0;
            in
            {
              top-left = radius;
              top-right = radius;
              bottom-left = radius;
              bottom-right = radius;
            };
          clip-to-geometry = true;
        }
      ];
    };
  };
}
