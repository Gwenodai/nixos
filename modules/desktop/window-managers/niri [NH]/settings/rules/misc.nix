{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.niri = {
    ...
  }: {
    programs.niri.settings = {
      window-rules = [
        { # Don't start bottles apps floating
          matches = [ { app-id = "^.*\\.exe"; } ];
          open-floating = false;
        }
        { # Floating file-roller
          matches = [ { app-id = "^org.gnome.FileRoller$"; } ];
          open-floating = true;
          max-height = 600;
          max-width = 900;
        }
      ];
    };
  };
}
