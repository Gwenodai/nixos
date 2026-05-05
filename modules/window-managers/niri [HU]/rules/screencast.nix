{ den, ... }:
{
  den.aspects.niri._.rules._.screencast = den.lib.perUser {
    homeManager = {
      programs.niri.settings = {
        window-rules = [
          {
            # Screencast blocklist
            matches = [
              { app-id = "^vesktop$"; }
              { app-id = "^Caprine$"; }
              {
                app-id = "^google-chrome$";
                title = "- Gmail";
              }
            ];
            block-out-from = "screencast";
          }
          {
            # Screencast target outline effect
            matches = [
              { is-window-cast-target = true; }
            ];
            border = {
              active.color = "#03fcf4bf";
              inactive.color = "#0398fcbf";
            };
            shadow = {
              color = "#03fcf470";
            };
          }
        ];

        layer-rules = [
          # { # Screencast blocklist
          #   matches = [
          #     { namespace = "notifications"; }
          #   ];

          #   block-out-from = "screencast";
          # }
        ];
      };
    };
  };
}
