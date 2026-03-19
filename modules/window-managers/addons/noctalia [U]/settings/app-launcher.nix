{ inputs, den, ... }: {
  den.aspects.noctalia._.settings._.app-launcher = den.lib.perUser {
    homeManager = { config, ... }: {
      programs.noctalia-shell.settings = {
        # ---Noctalia app launcher settings---
        appLauncher = inputs.self.lib.applyDefaults {
          enableClipboardHistory = true;
          autoPasteClipboard = false;
          enableClipPreview = true;
          clipboardWrapText = true;
          clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
          clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
          position = "center";
          pinnedApps = [];
          useApp2Unit = false;
          sortByMostUsed = true;
          terminalCommand = "kitty -e";
          customLaunchPrefixEnabled = false;
          customLaunchPrefix = "";
          viewMode = "list";
          showCategories = true;
          iconMode = "tabler";
          showIconBackground = false;
          enableSettingsSearch = true;
          enableWindowsSearch = false;
          enableSessionSearch = false;
          ignoreMouseInput = false;
          screenshotAnnotationTool = "";
          overviewLayer = false;
          density = "default";
        };
      };
    };
  };
}