# NOTE: The `extraConfig` attribute exposed by cmm's PR cannot be defined in
#       multiple places. Only modify it here.
{ lib, ... }:
{
  den.aspects.niri = {
    homeManager =
      { config, ... }:
      {
        # Rust highlighting is close enough to make kdl readable
        programs.niri.extraConfig = lib.replaceStrings [ "// syntax: rust\n" ] [ "" ] ''
          // syntax: rust
          recent-windows {
            highlight {
              padding 10
              corner-radius 20
            }

            binds {
              Alt+Tab         { next-window; }
              Alt+Shift+Tab   { previous-window; }
              Alt+grave       { next-window     filter="app-id"; }
              Alt+Shift+grave { previous-window filter="app-id"; }
            }
          }

          window-rule {
            background-effect {
              blur true
              xray false
            }
          }

          layer-rule {
            match namespace="^noctalia-(background|launcher-overlay|dock)-.*$"
            background-effect {
              xray false
            }
          }

          blur {
            passes 3        // more passes = stronger blur (default: 3)
            offset 2.0      // sample distance per pass (default: 3.0)
            noise 0.03      // grain overlay (default: 0.02)
            saturation 1.0  // color saturation boost (default: 1.5)
          }
        '';
      };
  };
}
