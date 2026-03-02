{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    config,
    lib,
    ...
  }: {
    programs.noctalia-shell.settings = {
        
      # ---Noctalia wallpaper settings---
      wallpaper = inputs.self.lib.applyDefaults {
        # Genereal
        enabled = true;
        setWallpaperOnAllMonitors = true;
        skipStartupTransition = false; # Wallpaper transition on login
        directory = "${config.xdg.userDirs.pictures}/Wallpapers";
        showHiddenFiles = false;
        viewMode = "single";
        fillMode = "crop";
        fillColor = "#000000";
        useSolidColor = false;
        solidColor = "#1a1a2e";
        panelPosition = "follow_bar";
        hideWallpaperFilenames = false;
        # Automation
        automationEnabled = true;
        wallpaperChangeMode = "random";
        randomIntervalSec = 180;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
        # Per monitor wallpaper settings
        enableMultiMonitorDirectories = false;
        monitorDirectories = [];
        # Overview settings
        overviewEnabled = true;
        overviewBlur = 0.4;
        overviewTint = 0.6;
        # Wallhaven settings
        useWallhaven = false;
        wallhavenQuery = "";
        wallhavenSorting = "relevance";
        wallhavenOrder = "desc";
        wallhavenCategories = "110";
        wallhavenPurity = "100";
        wallhavenRatios = "";
        wallhavenApiKey = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenResolutionHeight = "";
        sortOrder = "name";
        favorites = [];
      };
    };
  };
}