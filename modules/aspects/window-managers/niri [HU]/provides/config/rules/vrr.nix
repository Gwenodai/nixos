{ den, ... }:
let
  vrr = den.lib.perUser {
    homeManager = {
      programs.niri.settings = {
        window-rules = [
          {
            # VRR allowlist
            matches = [
              { app-id = "^steam_app.*"; } # Most steam games
              { app-id = "^RSG-Linux-Shipping$"; } # Everspace native linux version
              { app-id = "^vampire crawlers.exe$"; }
              # { app-id = "^riftbreaker_win_release.exe$"; }
            ];
            variable-refresh-rate = true;
            open-focused = true;
          }
          {
            # VRR blocklist
            matches = [
              {
                app-id = "^steam_app.*";
                title = "^Unrailed!$";
              }
              {
                app-id = "^steam_app.*";
                title = "^Dome Keeper$";
              }
              {
                app-id = "^re5dx9.exe$"; # RE:5
              }
              { app-id = "^steam_app_881100$"; } # Noita
              { app-id = "^steam_app_323190$"; } # Frostpunk
              # { app-id = "^steam_app_2246340$"; } # MH:Wilds
            ];
            variable-refresh-rate = false;
          }
        ];
      };
    };
  };
in
{
  den.aspects.niri._.config.includes = [ vrr ];
}
