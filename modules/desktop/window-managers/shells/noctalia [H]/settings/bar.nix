{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    ...
  }: {
    programs.noctalia-shell.settings = {
      
      # ---Noctalia bar settings---
      bar = inputs.self.lib.applyDefaults {
        barType = "simple";
        position = "top";
        monitors = [];
        screenOverrides = [];
        density = "default";
        showOutline = false;
        showCapsule = false;
        capsuleOpacity = 1;
        capsuleColorKey = "none";
        widgetSpacing = 0;
        contentPadding = 2;
        fontScale = 1;
        backgroundOpacity = 0.9;
        useSeparateOpacity = false;
        floating = false;
        marginVertical = 4;
        marginHorizontal = 4;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = true;
        hideOnOverview = true;
        displayMode = "always_visible";
        autoHideDelay = 500;
        autoShowDelay = 150;
        showOnWorkspaceSwitch = true;
        mouseWheelAction = "none";
        mouseWheelWrap = true;
        reverseScroll = false;
        widgets = {
          left = [
            {
              colorizeIcons = false;
              hideMode = "hidden";
              id = "ActiveWindow";
              maxWidth = 300;
              scrollingMode = "hover";
              showIcon = true;
              textColor = "none";
              useFixedWidth = false;
            }
          ];
          center = [
            {
              characterCount = 2;
              colorizeIcons = false;
              emptyColor = "secondary";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = true;
              iconScale = 0.8;
              id = "Workspace";
              labelMode = "index";
              occupiedColor = "secondary";
              pillSize = 0.6;
              showApplications = true;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 0.8;
            }
          ];
          right = [
            {
              compactMode = false;
              hideMode = "idle";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 500;
              panelShowAlbumArt = true;
              scrollingMode = "hover";
              showAlbumArt = false;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              textColor = "none";
              useFixedWidth = false;
              visualizerType = "wave";
            }
            {
              blacklist = [];
              chevronColor = "none";
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [];
            }
            {
              compactMode = true;
              diskPath = "/";
              iconColor = "none";
              id = "SystemMonitor";
              showCpuUsage = true;
              showCpuCores = false;
              showCpuFreq = false;
              showCpuTemp = false;
              showDiskAvailable = false;
              showDiskUsage = false;
              showDiskUsageAsPercent = false;
              showGpuTemp = false;
              showLoadAverage = false;
              showMemoryAsPercent = true;
              showMemoryUsage = true;
              showNetworkStats = false;
              showSwapUsage = false;
              textColor = "none";
              useMonospaceFont = true;
              usePadding = false;
            }
            {
              clockColor = "none";
              customFont = "";
              formatHorizontal = "h:mm AP";
              formatVertical = "HH mm";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
            }
            {
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              iconColor = "none";
              id = "NotificationHistory";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
            }
          ];
        };
      };
    };
  };
}