{
  den.aspects.stacy-pc._.to-users.niri = { config, lib, ... }: {
    settings = {
      # Nicer default size for 16:9 monitors
      layout.default-column-width.proportion = 1.0 / 2.0;
      
      # Cycle between monitor horizontally instead of vertically
      binds = with config.lib.niri.actions; lib.attrsets.mergeAttrsList [
        { # Sroll wheel focus navigation
          "Mod+Ctrl+WheelScrollUp".action   = focus-monitor-left;
          "Mod+Ctrl+WheelScrollDown".action = focus-monitor-right;
        }
      ];
    };
  };
}