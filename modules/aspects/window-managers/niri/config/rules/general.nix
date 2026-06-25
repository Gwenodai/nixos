{
  den.aspects.niri = {
    homeManager = {
      programs.niri.settings = {
        window-rules = [
          ### Relocate Steam notifications to the bottom right of the screen
          {
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
          #---Floating Blocklist---#
          {
            matches = [
              ## Steam games
              { app-id = "^steam_app.*"; }
              ## Bottles apps
              { app-id = "^.*\\.exe"; }
            ];
            open-floating = false;
          }
          ### File-roller
          {
            matches = [ { app-id = "org.gnome.FileRoller"; } ];
            open-floating = true;
            min-height = 600;
            min-width = 900;
          }
        ];
      };
    };
  };
}
