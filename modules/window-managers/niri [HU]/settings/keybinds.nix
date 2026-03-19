{ den, lib, ... }: {
  den.aspects.niri._.settings._.keybinds = den.lib.perUser {
    homeManager = { config, pkgs, ... }: {
      programs.niri.settings.binds = with config.lib.niri.actions; let
        # Makeshift `spawn-sh` functionality
        sh = spawn "sh" "-c";
        # Spawn a single package's executable
        spawnPkg = pkg: spawn (lib.getExe pkg);
        # Spawn an executable wrapped in Kitty
        spawnTermPkg = pkg: spawnPkg pkgs.kitty (lib.getExe pkg);
        # Apply the same action to a list of keys
        bindMany = keys: action: lib.genAttrs keys (key: { inherit action; });
      in
      lib.mapAttrs (_: value: lib.mkDefault value) (
        lib.attrsets.mergeAttrsList [
          { # Shortcuts
            "Mod+Escape".action = show-hotkey-overlay;
            "Mod+Tab".action    = toggle-overview;
            "Mod+Q" = { action  = close-window; repeat = false; };
          }
          { # Applications etc.
            # "Mod+R".action             = RUNNER;
            "Mod+T".action             = spawnPkg     pkgs.kitty;
            "Mod+E".action             = spawnPkg     pkgs.nemo;
            "Mod+G".action             = spawnPkg     pkgs.google-chrome;
            "Ctrl+Shift+Escape".action = spawnTermPkg pkgs.btop;
            "MoD+Shift+P".action       = power-off-monitors;
            "Mod+Ctrl+Shift+Q".action  = sh "pkill -9 winedevice.exe";
            # "MoD+Shift+C".action       = CLIPBOARD;
          }
          { # Fullscreen
            "Mod+F".action            = maximize-column;
            "Mod+Shift+F".action      = fullscreen-window;
            "Mod+Ctrl+F".action       = toggle-windowed-fullscreen;
            "Mod+Ctrl+Shift+F".action = maximize-window-to-edges;
          }
          { # Screenshots
            "Print".action.           screenshot-window = [];
            "Ctrl+Print".action.      screenshot-screen = { show-pointer = false; };
            "Ctrl+Shift+Print".action.screenshot        = { show-pointer = false; };
          }
          { # Screenshare
            "Mod+Print".action       = set-dynamic-cast-window;
            "Mod+Ctrl+Print".action  = set-dynamic-cast-monitor;
            "Mod+Shift+Print".action = clear-dynamic-cast-target;
          }
          { # Audio keys
            # "XF86AudioMute".action = spawn MUTE AUDIO;
            # "XF86AudioRaiseVolume".action = spawn RAISE VOLUME;
            # "XF86AudioLowerVolume".action = spawn LOWER VOLUME;
          }
          ( # Music keys
            let
              spotifyControl = command: {
                action = spawnPkg pkgs.playerctl "--player=spotify" command;
                allow-when-locked = true;
              };
            in {
              "XF86AudioPlay" = spotifyControl "play-pause";
              "XF86AudioStop" = spotifyControl "stop";
              "XF86AudioNext" = spotifyControl "next";
              "XF86AudioPrev" = spotifyControl "previous";
            }
          )
          { # Window actions
            "Mod+Z".action       = switch-preset-column-width;
            "Mod+Shift+Z".action = reset-window-height;
            "Mod+X".action       = center-column;
            "Mod+Shift+X".action = center-visible-columns;
            "Mod+C".action       = expand-column-to-available-width;
            "Mod+V".action       = toggle-window-floating;
            "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
          }
            # Focus navigation
          ( bindMany [ "Mod+W" "Mod+Up" ]        focus-workspace-up )
          ( bindMany [ "Mod+S" "Mod+Down" ]      focus-workspace-down)
          ( bindMany [ "Mod+A" "Mod+Left" ]      focus-window-up-or-column-left  )
          ( bindMany [ "Mod+D" "Mod+Right" ]     focus-window-down-or-column-right  )
          { # Sroll wheel focus navigation
            "Mod+WheelScrollUp" = { action     = focus-workspace-up;   cooldown-ms = 150; };
            "Mod+WheelScrollDown" = { action   = focus-workspace-down; cooldown-ms = 150; };
            "Mod+Shift+WheelScrollUp".action   = focus-column-left;
            "Mod+Shift+WheelScrollDown".action = focus-column-right;
            "Mod+Ctrl+WheelScrollUp".action    = focus-monitor-up;
            "Mod+Ctrl+WheelScrollDown".action  = focus-monitor-down;
          }
            # Move columns
          ( bindMany [ "Mod+Shift+W" "Mod+Shift+Up" ]    move-column-to-workspace-up )
          ( bindMany [ "Mod+Shift+S" "Mod+Shift+Down" ]  move-column-to-workspace-down )
          ( bindMany [ "Mod+Shift+A" "Mod+Shift+Left" ]  move-column-left )
          ( bindMany [ "Mod+Shift+D" "Mod+Shift+Right" ] move-column-right )
            # Move windows
          ( bindMany [ "Mod+Ctrl+W" "Mod+Ctrl+Up" ]      move-window-up )
          ( bindMany [ "Mod+Ctrl+S" "Mod+Ctrl+Down" ]    move-window-down )
          ( bindMany [ "Mod+Ctrl+A" "Mod+Ctrl+Left" ]    consume-or-expel-window-left )
          ( bindMany [ "Mod+Ctrl+D" "Mod+Ctrl+Right" ]   consume-or-expel-window-right )

          ( # Mod+[1-9] = Focus workspace | Mod+Shift+[1-9] = Move column to workspace
            lib.attrsets.mergeAttrsList (
              lib.map (number: {
                "Mod+${toString number}".action = focus-workspace number;
                "Mod+Shift+${toString number}".action.move-column-to-workspace = [ { focus = false; } number ];
              }) [ 1 2 3 4 5 6 7 8 9 ]
            )
          )
        ]
      );
    };
  };
}