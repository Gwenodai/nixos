{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.niri = {
    ...
  }: {
    programs.niri.settings = {
      window-rules = [
        { # Relocate Steam notifications to the bottom right of the screen
          matches = [
            { app-id = "steam"; title = "^notificationtoasts_\\d+_desktop$"; }
          ];
          default-floating-position = {
            x = 2;
            y = 2;
            relative-to = "bottom-right";
          };
          open-focused = false;
        }
        { # Don't start Steam games floating
          matches = [ { app-id = "^steam_app.*"; } ];
          open-floating = false;
        }
      ];
    };
  };
}
