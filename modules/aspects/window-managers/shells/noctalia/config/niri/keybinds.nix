{
  den.aspects.noctalia = {
    niri =
      { config, lib, ... }:
      {
        settings.binds =
          with config.lib.niri.actions;
          let
            # Makeshift `spawn-sh` functionality
            sh = spawn "sh" "-c";
            # Noctalia IPC command runner
            noct = command: {
              action = sh "noctalia msg ${command}";
            };
            # Noctalia IPC command runner available on lock screen
            noctWhileLocked =
              command:
              (noct command)
              // {
                allow-when-locked = true;
              };
          in
          lib.mapAttrs (key: value: lib.mkOverride 900 value) (
            lib.attrsets.mergeAttrsList [
              ## Launcher
              {
                "Mod+R" = noct "panel-toggle launcher";
                "MoD+Ctrl+C" = noct "panel-toggle clipboard";
              }
              ## Media shortcut keys
              {
                "XF86AudioMute" = noctWhileLocked "volume-mute";
                "XF86AudioRaiseVolume" = noctWhileLocked "volume-up";
                "XF86AudioLowerVolume" = noctWhileLocked "volume-down";
              }
            ]
          );
      };
  };
}
