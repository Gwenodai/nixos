{
  den.aspects.niri = {
    homeManager = {
      programs.niri.settings = {
        window-rules = [
          #---Game VRR Allowlist---#
          {
            matches = [
              ## Most steam games
              { app-id = "^steam_app.*"; }
              ## Everspace native linux version
              { app-id = "^RSG-Linux-Shipping$"; }
              ## Vampire crawlers
              { app-id = "^vampire crawlers.exe$"; }
              ## Riftbreaker
              # { app-id = "^riftbreaker_win_release.exe$"; }
              ## Halo: MCC
              { app-id = "^mcc-win64-shipping.exe$"; }
            ];
            variable-refresh-rate = true;
            open-focused = true;
          }
          #---VRR Blocklist---#
          {
            matches = [
              ## Unrailed!
              {
                app-id = "^steam_app.*";
                title = "^Unrailed!$";
              }
              ## Dome Keeper
              {
                app-id = "^steam_app.*";
                title = "^Dome Keeper$";
              }
              ## RE:5
              { app-id = "^re5dx9.exe$"; }
              ## Noita
              { app-id = "^steam_app_881100$"; }
              ## Frostpunk
              { app-id = "^steam_app_323190$"; }
              ## MH:Wilds
              # { app-id = "^steam_app_2246340$"; }
            ];
            variable-refresh-rate = false;
          }
        ];
      };
    };
  };
}
