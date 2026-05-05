{ den, ... }:
{
  den.aspects.niri._.rules._.general = den.lib.perUser {
    homeManager = {
      programs.niri.settings = {
        window-rules = [
          {
            # Relocate Steam notifications to the bottom right of the screen
            matches = [
              {
                app-id = "steam";
                title = "^notificationtoasts_\\d+_desktop$";
              }
            ];
            default-floating-position = {
              x = 2;
              y = 2;
              relative-to = "bottom-right";
            };
            open-focused = false;
          }
          {
            # Don't start Steam games floating
            matches = [ { app-id = "^steam_app.*"; } ];
            open-floating = false;
          }
          {
            # Don't start bottles apps floating
            matches = [ { app-id = "^.*\\.exe"; } ];
            open-floating = false;
          }
          {
            # Floating file-roller
            matches = [ { app-id = "^org.gnome.FileRoller$"; } ];
            open-floating = true;
            max-height = 600;
            max-width = 900;
          }
        ];
      };
    };
  };
}
