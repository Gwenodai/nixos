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
              id = "ActiveWindow";
              colorizeIcons = false;
              hideMode = "hidden";
              maxWidth = 300;
              scrollingMode = "hover";
              showIcon = true;
              textColor = "none";
              useFixedWidth = false;
            }
          ];
          center = [
            {
              id = "Workspace";
              characterCount = 2;
              colorizeIcons = false;
              emptyColor = "secondary";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = true;
              iconScale = 0.8;
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
              id = "MediaMini";
              compactMode = false;
              hideMode = "idle";
              hideWhenIdle = false;
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
              id = "Tray";
              blacklist = [];
              chevronColor = "none";
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              pinned = [
                "Vesktop"
                "Caprine"
              ];
            }
            {
              id = "SystemMonitor";
              compactMode = true;
              diskPath = "/";
              iconColor = "none";
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
              id = "Clock";
              clockColor = "none";
              customFont = "";
              formatHorizontal = "h:mm AP";
              formatVertical = "HH mm";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
            }
            {
              id = "Volume";
              displayMode = "onhover";
              iconColor = "none";
              middleClickCommand = "pwvucontrol || pavucontrol";
              textColor = "none";
            }
            {
              id = "NotificationHistory";
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              iconColor = "none";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
            }
          ];
        };
      };
    };
  };
}