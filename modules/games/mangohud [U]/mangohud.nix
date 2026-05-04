{ inputs, den, ... }:
{
  # https://mynixos.com/home-manager/options/programs.mangohud
  den.aspects.mangohud = {
    includes = with den.aspects.mangohud._; [
      enable
      config
    ];

    _.enable = den.lib.perUser {
      homeManager =
        { pkgs, lib, ... }:
        {
          programs.mangohud = {
            enable = lib.mkDefault true;
          };
        };
    };

    _.config = den.lib.perUser {
      homeManager =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        let
          # Creates and uses temporary mangohud configs when launching games.
          # Works around mangohud's `read_cfg` errors by giving it a regular config file.
          # Use within game launch options like: `mhfps 240 %command%`
          mangohudPrependFps = pkgs.writeShellApplication {
            name = "mhfps";
            runtimeInputs = [ pkgs.gnused ];
            text = ''
              if [ "$#" -lt 2 ]; then
                echo "Usage: mhfps <fps_limit> <command...>" >&2
                exit 1
              fi

              FPS=$1
              shift

              mkdir -p "${config.xdg.cacheHome}"
              sed "s/^fps_limit=\(.*\)/fps_limit=$FPS,\1/" "${config.xdg.configHome}/MangoHud/MangoHud.conf" > "${config.xdg.cacheHome}/mh-tmp.conf"

              MANGOHUD_CONFIGFILE="${config.xdg.cacheHome}/mh-tmp.conf" exec mangohud "$@"
            '';
          };
        in
        {
          home.packages = [ mangohudPrependFps ];

          programs.mangohud = {
            settings = inputs.self.lib.applyDefaults {
              # ---Performance--- #
              # `vulkan_present_mode` Needs mangohud 0.8.3
              # vulkan_present_mode = "mailbox"; # Takes precedence over `vsync=`
              vsync = 2; # mailbox
              gl_vsync = 1; # on
              # late = lowest latency. early = smoothest frametimes
              fps_limit_method = "late";
              fps_limit = [
                223 # (REFRESH×(1−REFRESH×0.00028))
                0
                120
                60
                30
              ];

              # ---UI--- #
              # Pre-defined presets
              preset = [
                1 # No UI
                2 # Only fps counter
                3 # Minimal GPU and frame metrics
              ];

              # HUD
              position = "top-left";
              background_alpha = 0.2;
              round_corners = 10;
              background_color = "000000";
              # Dimensions
              width = 225;
              table_columns = 3;
              # Text
              font_size = 24;
              text_color = "FFFFFF";

              # FPS/Frametime
              fps_color_change = true;
              fps_color = [
                "B22222"
                "FDFD09"
                "39F900"
              ];
              fps_value = [
                60
                120
              ];
              frametime_color = "00FF00";

              # ---Hotkeys--- #
              toggle_fps_limit = "Shift_L+F1";
              toggle_preset = "Shift_L+F2";
              toggle_logging = "Shift_L+F10";
              toggle_hud_position = "Shift_R+F11";
              toggle_hud = "Shift_R+F12"; # Doesn't seem to work
              reload_cfg = "Shift_L+F4";
              upload_log = "Shift_L+F3";
              reset_fps_metrics = "Shift_R+f9";

              # ---Logging--- #
              output_folder = "${config.xdg.configHome}/MangoHud/logs";
              log_duration = 30;
              autostart_log = 0;
              log_interval = 100;
            };
          };

          home.file."${config.xdg.configHome}/MangoHud/presets.conf" = lib.mkDefault {
            text = ''
              [preset 1]
              no_display

              [preset 2]
              fps_only

              [preset 3]
              gpu_text=GPU
              gpu_stats
              fps
              fps_metrics=avg,0.01
              dynamic_frame_timing
            '';
            force = true;
          };
        };
    };
  };
}
