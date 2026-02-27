{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    ...
  }: {
    programs.noctalia-shell.settings.general = inputs.self.lib.applyDefaults {
      avatarImage = "";
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
      compactLockScreen = false;
      lockScreenAnimations = true;
      lockOnSuspend = true;
      showSessionButtonsOnLockScreen = true;
      showHibernateOnLockScreen = false;
      enableShadows = true;
      shadowDirection = "bottom_right";
      shadowOffsetX = 2;
      shadowOffsetY = 3;
      language = "";
      allowPanelsOnScreenWithoutBar = true;
      showChangelogOnStartup = true;
      telemetryEnabled = false;
      enableLockScreenCountdown = true;
      lockScreenCountdownDuration = 10000;
      autoStartAuth = false;
      allowPasswordWithFprintd = false;
      clockStyle = "digital";
      clockFormat = "hh\\nmm";
      passwordChars = false;
      lockScreenMonitors = [];
      lockScreenBlur = 0.6;
      lockScreenTint = 0;
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
        ];
        keyEscape = [
          "Esc"
        ];
        keyRemove = [
          "Del"
        ];
      };
      reverseScroll = false;
    };
  };
}