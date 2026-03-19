{ inputs, den, ... }: {
  den.aspects.noctalia._.settings._.ui = den.lib.perUser {
    homeManager = { config, lib, ... }: {
      programs.noctalia-shell.settings = {
        # ---Noctalia UI settings---
        ui = inputs.self.lib.applyDefaults {
          # UI
          tooltipsEnabled = true;
          boxBorderEnabled = false;
          panelBackgroundOpacity = 0.9;
          panelsAttachedToBar = true;
          settingsPanelMode = "attached";
          settingsPanelSideBarCardStyle = false;
          # Fonts
          fontDefault = "Adwaita Sans";
          fontFixed = "JetBrainsMono NF";
          fontDefaultScale = 1;
          fontFixedScale = 1;
        };

        # ---Noctalia calendar settings---
        calendar = {
          cards = lib.mkDefault [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };

        # ---Noctalia control center settings---
        controlCenter = inputs.self.lib.applyDefaults {
          position = "close_to_bar_button";
          diskPath = "/";
          shortcuts = {
            left = [
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "WallpaperSelector";
              }
              {
                id = "NoctaliaPerformance";
              }
            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "KeepAwake";
              }
              {
                id = "NightLight";
              }
            ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = false;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = false;
              id = "brightness-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };

        # ---Noctalia on-screen display settings---
        osd = inputs.self.lib.applyDefaults {
          enabled = true; # UI popups when changing volume/brightness etc
          location = "top_right";
          autoHideMs = 2000;
          overlayLayer = true;
          backgroundOpacity = 1;
          enabledTypes = [
            0 # Output volume
            1 # Input volume
            2 # Brightness
            # 3  # Lock keys (caps/num lock etc)
          ];
          # Only show on specific monitors?
          monitors = [];
        };

        # ---Noctalia colour scheme settings---
        colorSchemes = inputs.self.lib.applyDefaults {
          # Dark mode
          darkMode = true;
          schedulingMode = "off";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          # Wallpaper colour settings
          useWallpaperColors = false;
          generationMethod = "tonal-spot";
          monitorForColors = ""; # Use a specific monitor for colour detection
          # Manual colour scheme
          predefinedScheme = "Rose Pine";
        };

        # ---Noctalia night light settings---
        nightLight = inputs.self.lib.applyDefaults {
          enabled = false;
          forced = false;
          autoSchedule = true;
          nightTemp = "4000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "18:30";
        };

        # ---Noctalia desktop widget settings---
        desktopWidgets = inputs.self.lib.applyDefaults {
          enabled = false;
          gridSnap = false;
          overviewEnabled = true; # Show in overview
          monitorWidgets = [];
        };

        # ---Noctalia template settings---
        templates = inputs.self.lib.applyDefaults {
          enableUserTheming = false;
          activeTemplates = [];
        };
      };
    };
  };
}