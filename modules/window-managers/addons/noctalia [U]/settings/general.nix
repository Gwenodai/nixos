{ inputs, den, ... }: {
  den.aspects.noctalia._.settings._.general = den.lib.perUser {
    homeManager = { config, lib, ... }: {
      programs.noctalia-shell.settings = {
        # ---Noctalia settings version---
        settingsVersion = lib.mkDefault 57;
        
        # ---Noctalia general settings---
        general = inputs.self.lib.applyDefaults {
          # General
          avatarImage = "";
          language = "";
          telemetryEnabled = false;
          showChangelogOnStartup = true;
          # UI
          dimmerOpacity = 0.2;
          showScreenCorners = true;
          forceBlackScreenCorners = true;
          scaleRatio = 1;
          radiusRatio = 1;
          iRadiusRatio = 1;
          boxRadiusRatio = 1;
          screenRadiusRatio = 1;
          animationSpeed = 1;
          animationDisabled = false;
          allowPanelsOnScreenWithoutBar = true;
          reverseScroll = false;
          # Lock screen
          compactLockScreen = false;
          lockScreenAnimations = true;
          lockOnSuspend = true;
          showSessionButtonsOnLockScreen = true;
          showHibernateOnLockScreen = false;
          enableLockScreenCountdown = true;
          enableLockScreenMediaControls = true;
          lockScreenCountdownDuration = 10000;
          autoStartAuth = false;
          allowPasswordWithFprintd = false;
          enableBlurBehind = true;
          clockStyle = "digital";
          clockFormat = "hh\\nmm";
          passwordChars = false;
          lockScreenMonitors = [];
          lockScreenBlur = 0.6;
          lockScreenTint = 0;
          # Shadows
          enableShadows = true;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          # Keybinds
          keybinds = {
            keyUp = [
              "Up"
            ];
            keyDown = [
              "Down"
            ];
            keyLeft = [
              "Left"
            ];
            keyRight = [
              "Right"
            ];
            keyEnter = [
              "Return"
              "Enter"
            ];
            keyEscape = [
              "Esc"
            ];
            keyRemove = [
              "Del"
            ];
          };
        };
      };
    };
  };
}