{ inputs, den, ... }: {
  den.aspects.noctalia._.settings._.dock = den.lib.perUser {
    homeManager = { config, ... }: {
      programs.noctalia-shell.settings = {
        # ---Noctalia dock settings---
        dock = inputs.self.lib.applyDefaults {
          enabled = false;
          showDockIndicator = true;
          position = "bottom";
          displayMode = "auto_hide";
          dockType = "floating";
          backgroundOpacity = 1;
          floatingRatio = 1;
          size = 1;
          onlySameOutput = true;
          monitors = [];
          pinnedApps = [];
          colorizeIcons = false;
          showLauncherIcon = false;
          launcherPosition = "end";
          launcherIconColor = "none";
          pinnedStatic = false;
          inactiveIndicators = false;
          indicatorColor = "primary";
          indicatorOpacity = 0.6;
          indicatorThickness = 3;
          groupApps = false;
          groupContextMenuMode = "extended";
          groupClickAction = "cycle";
          groupIndicatorStyle = "dots";
          deadOpacity = 0.6;
          animationSpeed = 1;
          sitOnFrame = false;
        };
      };
    };
  };
}