# Minimal desktop shell for Niri/Hyprland
# https://noctalia.dev/
{
  ...
}:
{
  den.aspects.noctalia = {
    homeManager = { config, ... }: {
      home.file."${config.xdg.stateHome}/noctalia/.setup-complete".text = "";
      programs.noctalia.settings = {
        audio.enable_overdrive = true;
        backdrop.enabled = true;

        bar = {
          order = [ "default" ];
          default = {
            background_opacity = 0.75;
            center = [ "workspaces" ];
            end = [
              "media"
              "tray"
              "spacer_2"
              "battery"
              "brightness"
              "volume"
              "notifications"
            ];
            margin_edge = 5;
            margin_ends = 5;
            radius = 20;
            start = [
              "clock"
              "active_window"
            ];
          };
        };

        calendar.enabled = true;
        desktop_widgets.enabled = false;

        dock = {
          auto_hide = true;
          background_opacity = 0.75;
          enabled = true;
          position = "right";
          reserve_space = false;
          show_dots = true;
          show_instance_count = false;
        };

        idle = {
          behavior_order = [
            "screen-off"
            "lock"
            "lock-and-suspend"
          ];
          behavior = {
            screen-off = {
              action = "screen_off";
              enabled = true;
              timeout = 180.0;
            };
            lock = {
              action = "lock";
              enabled = true;
              timeout = 300.0;
            };
            lock-and-suspend = {
              action = "lock_and_suspend";
              enabled = true;
              timeout = 1800.0;
            };
          };
        };

        location.auto_locate = true;
        lockscreen.fingerprint = false;

        notification = {
          background_opacity = 0.75;
          layer = "overlay";
        };

        osd = {
          background_opacity = 0.75;
          kinds = {
            lock_keys = false;
            media = false;
          };
        };

        shell = {
          avatar_path = "${config.xdg.userDirs.pictures}/.avatar";
          clipboard_auto_paste = "off";
          launch_apps_as_systemd_services = true;
          niri_overview_type_to_launch_enabled = true;
          polkit_agent = true;
          screen_time_enabled = true;
          settings_show_advanced = true;
          panel = {
            borders = false;
            open_near_click_control_center = true;
            open_near_click_session = true;
            transparency_mode = "soft";
          };
          screen_corners.enabled = true;
        };

        theme = {
          community_palette = "Rosey AMOLED";
          mode = "dark";
          pure_black_dark = true;
          source = "wallpaper";
        };

        wallpaper = {
          directory = "${config.xdg.userDirs.pictures}/Wallpapers";
          transition = [
            "disc"
            "wipe"
          ];
          transition_on_startup = true;
          automation = {
            enabled = true;
            interval_seconds = 180;
          };
        };

        widget = {
          active_window = {
            font_family = "Adwaita Sans";
            font_weight = 500;
            icon_size = 20;
            max_length = 600;
            title_scroll = "always";
          };
          clock = {
            font_family = "JetBrainsMono NF";
            font_weight = 700;
          };
          media = {
            art_size = 24;
            font_family = "Fira Sans";
            font_weight = 400;
            hide_when_no_media = true;
            max_length = 500;
            title_scroll = "always";
          };
          notifications = {
            scale = 1.2;
          };
          spacer_2 = {
            length = 10;
            type = "spacer";
          };
          tray = {
            drawer = true;
            pinned = [
              "Steam"
              "Vesktop"
              "Caprine"
              "KDE Connect Indicator"
            ];
          };
          volume = {
            scale = 1.2;
            show_label = false;
          };
          workspaces = {
            font_family = "Adwaita Sans";
            font_weight = 1000;
            hide_when_empty = true;
            labels_only_when_occupied = true;
          };
        };
      };
    };
  };
}
