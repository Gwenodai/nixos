# https://mynixos.com/home-manager/options/programs.mangohud
{
  den.aspects.mangohud = {
    homeManager =
      {
        config,
        pkgs,
        host,
        lib,
        ...
      }:
      let
        # Creates and uses a temporary mangohud config when launching games.
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

        ### Host Display Code
        # Logic to check hosts main display and store info about it
        mainDisplay =
          lib.findSingle (d: d.focus-at-startup or false) null
            (abort "Error: Multiple displays have focus-at-startup set!")
            (lib.attrValues host.hardware.display);
        getRefreshRate = mainDisplay.mode.refresh or 60;
        roundedRefresh = lib.floor (getRefreshRate + 0.5);
        refreshHigherThanSixty = roundedRefresh > 60;
        # Optimal VRR fps cap = REFRESH-(REFRESH×REFRESH/3600)
        calculatedFps = lib.floor (roundedRefresh - (roundedRefresh * roundedRefresh / 3600.00) + 0.5);
        hasVrr =
          (mainDisplay.variable-refresh-rate or null) != null
          && (mainDisplay.variable-refresh-rate == true || mainDisplay.variable-refresh-rate == "on-demand");

        # Automatically generate optimal fps caps based on gathered data
        fpsLimitList =
          let
            isVrrDisplay = hasVrr && refreshHigherThanSixty;
            IsHighRefreshDisplay = refreshHigherThanSixty;
          in
          lib.optional isVrrDisplay calculatedFps
          ++ [ roundedRefresh ]
          ++ lib.optional (roundedRefresh > 120) 120
          ++ lib.optional IsHighRefreshDisplay 60
          ++ [
            30
            0
          ];
      in
      {
        programs.mangohud = {
          enable = true;
          settings = {
            ### Performance settings
            vulkan_present_mode = "mailbox"; # Takes precedence over `vsync=`
            vsync = 2; # mailbox
            gl_vsync = 1; # on
            # late = lowest latency. early = smoothest frametimes
            fps_limit_method = "late";
            fps_limit = fpsLimitList;

            ### Preset settings
            preset = [
              1 # No UI
              2 # Only fps counter
              3 # Minimal GPU and fps/frametime metrics
            ];

            ### HUD settings
            ## Style
            position = "top-left";
            background_alpha = 0.2;
            round_corners = 10;
            background_color = "000000";
            ## Dimensions
            width = 225;
            table_columns = 3;
            ## Text
            font_size = 24;
            text_color = "FFFFFF";

            ## FPS values and colours
            fps_color_change = true;
            fps_value = [
              60 # Low fps value
              120 # High fps value
            ];
            fps_color = [
              # Low-- colour
              "B22222" # Red
              # Low-high colour
              "FDFD09" # Yellow
              # High++ colour
              "39F900" # Green
            ];
            frametime_color = "00FF00"; # Green

            ## GPU values and colours
            gpu_load_change = true;
            gpu_load_value = [
              50 # Low GPU load value
              90 # High GPU load value
            ];
            gpu_load_color = [
              # Low-- colour
              "B22222" # Blue
              # Low-high colour
              "FDFD09" # Cyan
              # High++ colour
              "39F900" # Magenta
            ];

            ### Hotkey settings
            toggle_fps_limit = "Shift_L+F1";
            toggle_preset = "Shift_L+F2";
            toggle_logging = "Shift_L+F10";
            toggle_hud_position = "Shift_R+F11";
            toggle_hud = "Shift_R+F12"; # Doesn't seem to work
            reload_cfg = "Shift_L+F4";
            upload_log = "Shift_L+F3";
            reset_fps_metrics = "Shift_R+f9";

            ### Logging settings
            # "~/.config/MangoHud/logs"
            output_folder = "${config.xdg.configHome}/MangoHud/logs";
            log_duration = 30;
            autostart_log = 0;
            log_interval = 100;
          };
        };

        # "~/.config/MangoHud/presets.conf"
        home.file."${config.xdg.configHome}/MangoHud/presets.conf" = {
          text = ''
            [preset 1]
            no_display

            [preset 2]
            fps_only

            [preset 3]
            cpu_stats=0
            fps_metrics=avg,0.01
            dynamic_frame_timing
          '';
          force = true;
        };

        home.packages = [ mangohudPrependFps ];
      };
  };
}
