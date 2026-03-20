{ den, ... }: {
  den.aspects.noctalia._.niri._.keybinds = den.lib.perUser {
    niri = { config, lib, ... }: {
      settings.binds = with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c"; # Makeshift `spawn-sh` functionality
          # Noctalia IPC command runner
          noctalia = command: {
            action = sh "noctalia-shell ipc call ${command}";
          };
          # Noctalia IPC command runner available on lock screen
          noctaliaWhileLocked = command: (noctalia command) // {
            allow-when-locked = true;
          };
        in
      lib.mapAttrs (key: value: lib.mkOverride 900 value) (
        lib.attrsets.mergeAttrsList [
          { # Launcher
            "Mod+R"       = noctalia "launcher toggle";
            "Mod+Shift+R" = noctalia "launcher command";
            "MoD+Ctrl+C"  = noctalia "launcher clipboard";
          }
          { # Audio keys
            "XF86AudioMute"        = noctaliaWhileLocked "volume muteOutput";
            "XF86AudioRaiseVolume" = noctaliaWhileLocked "volume increase";
            "XF86AudioLowerVolume" = noctaliaWhileLocked "volume decrease";
          }
          { # Plugins
            "Mod+Escape" = noctalia "plugin:keybind-cheatsheet toggle";
          }
        ]
      );
    };
  };
}