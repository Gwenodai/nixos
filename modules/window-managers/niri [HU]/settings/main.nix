{
  inputs,
  den,
  lib,
  ...
}:
{
  den.aspects.niri._.settings._.main = den.lib.perUser {
    homeManager =
      { config, ... }:
      {
        programs.niri.settings = inputs.self.lib.applyDefaultsRecursive {
          prefer-no-csd = true;
          hotkey-overlay.skip-at-startup = true;

          cursor = {
            theme = "Vimix-cursors";
            size = 24;
            hide-after-inactive-ms = 2000;
          };

          gestures = {
            hot-corners.enable = false;
            dnd-edge-view-scroll = {
              trigger-width = 50;
              max-speed = 4000;
            };
            dnd-edge-workspace-switch = {
              trigger-height = 150;
              max-speed = 3000;
            };
          };

          layout = {
            gaps = 3;
            struts.top = 1;
            center-focused-column = "never";
            always-center-single-column = true;
            empty-workspace-above-first = true;
            default-column-display = "normal";
            background-color = "transparent";

            default-column-width.proportion = 1.0 / 3.0;
            preset-column-widths = [
              { proportion = 1.0 / 3.0; }
              { proportion = 1.0 / 2.0; }
              { proportion = 2.0 / 3.0; }
            ];

            focus-ring = {
              enable = false;
              width = 2;
              active.color = "#ff00adbf";
              inactive.color = "#59595933";
            };

            border = {
              enable = true;
              width = 2;
              active.color = "#ff00adbf";
              inactive.color = "#ff00ad33";
            };

            shadow.enable = true;

            insert-hint = {
              enable = true;
              display.color = "#ff00ad80";
            };
          };

          screenshot-path = "${config.xdg.userDirs.pictures}/Screenshots/%Y-%m-%d %H-%M-%S.png";

          debug.skip-cursor-only-updates-during-vrr = [ ];
        };

        # Stupid extension... Rust highlighting is close enough to make kdl readable
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
        '';
      };
  };
}
