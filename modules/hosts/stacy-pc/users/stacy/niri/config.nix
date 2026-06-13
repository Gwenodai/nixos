{
  den.aspects.stacy-pc = {
    niri =
      { config, lib, ... }:
      {
        settings = {
          binds =
            with config.lib.niri.actions;
            let
              sh = spawn "sh" "-c";
            in
            lib.attrsets.mergeAttrsList [
              {
                #########################
                ##  SET KEYBINDS HERE  ##
                #########################
                # Cycle between monitor horizontally instead of vertically
                "Mod+Ctrl+WheelScrollUp".action = focus-monitor-left;
                "Mod+Ctrl+WheelScrollDown".action = focus-monitor-right;
                # Activate camera focus fix
                "Mod+M".action = sh "fix-camera";
              }
            ];

          # Nicer default size for 16:9 monitors
          layout.default-column-width.proportion = 1.0 / 2.0;

          window-rules = [
            # Chrome opens at 100% screen width
            {
              matches = [ { app-id = "^google-chrome$"; } ];
              default-column-width.proportion = 1.0;
            }
          ];
        };
      };
  };
}
