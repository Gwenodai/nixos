{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    ...
  }: {
    programs.noctalia-shell.settings.dock = inputs.self.lib.applyDefaults {
      enabled = false;
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
      groupApps = false;
      groupContextMenuMode = "extended";
      groupClickAction = "cycle";
      groupIndicatorStyle = "dots";
      deadOpacity = 0.6;
      animationSpeed = 1;
      sitOnFrame = false;
      showFrameIndicator = true;
    };
  };
}