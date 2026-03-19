{ inputs, den, ... }: {
  den.aspects.noctalia._.settings._.system = den.lib.perUser {
    homeManager = { config, ... }: {
      programs.noctalia-shell.settings = {
        # ---Noctalia network settings---
        network = inputs.self.lib.applyDefaults {
          # --Settings--
            # Wi-Fi
            wifiEnabled = true;
            airplaneModeEnabled = false;
            # Bluetooth
            bluetoothAutoConnect = false;
            disableDiscoverability = false;
            bluetoothRssiPollingEnabled = false;
            bluetoothRssiPollIntervalMs = 60000;
            bluetoothHideUnnamedDevices = false;
          
          # --UI--
          networkPanelView = "wifi";
            # Wi-Fi
            wifiDetailsViewMode = "grid";
            # Bluetooth
            bluetoothDetailsViewMode = "grid";
        };
        
        # ---Noctalia audio settings---
        audio = inputs.self.lib.applyDefaults {
          # Volume
          volumeStep = 5;
          volumeOverdrive = true;
          volumeFeedback = false;
          volumeFeedbackSoundFile = "";
          # Media
          preferredPlayer = "";
          mprisBlacklist = [];
          #Visualiser
          spectrumFrameRate = 30;
          visualizerType = "linear";
        };
        
        # ---Noctalia brightness settings---
        brightness = inputs.self.lib.applyDefaults {
          brightnessStep = 5;
          enforceMinimum = true;
          enableDdcSupport = false; # External display brightness control
          backlightDeviceMappings = [];
        };

        # ---Noctalia location settings---
        location = inputs.self.lib.applyDefaults {
          # Weather
          name = "yagoona";
          weatherEnabled = true;
          weatherShowEffects = true;
          useFahrenheit = false;
          # Calendar
          showWeekNumberInCalendar = true;
          showCalendarEvents = true;
          showCalendarWeather = true;
          analogClockInCalendar = false;
          firstDayOfWeek = 1;
          # Location UI
          use12hourFormat = false;
          hideWeatherTimezone = false; # Hide details in UI?
          hideWeatherCityName = false; # Hide details in UI?
        };

        # ---Noctalia performance settings---
        noctaliaPerformance = inputs.self.lib.applyDefaults {
          disableWallpaper = true;
          disableDesktopWidgets = true;
        };

        # ---Noctalia hooks settings---
        hooks = inputs.self.lib.applyDefaults {
          enabled = false;
          startup = ""; # Niri startup completed
          session = ""; # Shutdown/Reboot
          wallpaperChange = "";
          darkModeChange = "";
          screenLock = "";
          screenUnlock = "";
          performanceModeEnabled = "";
          performanceModeDisabled = "";
        };

        # ---Noctalia system monitor settings---
        systemMonitor = inputs.self.lib.applyDefaults {
          # Colour config
          useCustomColors = false;
          warningColor = "";
          criticalColor = "";
          # CPU
          cpuWarningThreshold = 80;
          cpuCriticalThreshold = 90;
          # Temp
          tempWarningThreshold = 80;
          tempCriticalThreshold = 90;
          # GPU
          enableDgpuMonitoring = false;
          gpuWarningThreshold = 80;
          gpuCriticalThreshold = 90;
          # RAM
          memWarningThreshold = 80;
          memCriticalThreshold = 90;
          # Swap
          swapWarningThreshold = 80;
          swapCriticalThreshold = 90;
          # Disk
          diskWarningThreshold = 80;
          diskCriticalThreshold = 90;
          diskAvailWarningThreshold = 20;
          diskAvailCriticalThreshold = 10;
          # Battery
          batteryWarningThreshold = 20;
          batteryCriticalThreshold = 5;
          # External system monitor program
          externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
        };
      };
    };
  };
}