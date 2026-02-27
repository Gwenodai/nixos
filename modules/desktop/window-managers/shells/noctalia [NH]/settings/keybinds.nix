{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.noctalia = {
    options,
    config,
    lib,
    ...
  }: {
    config = inputs.self.lib.mkIfNiri { inherit options; } {
      programs.niri.settings.binds = with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c";
        in
      lib.attrsets.mergeAttrsList [
        { # Launcher
          "Mod+R".action       = sh "noctalia-shell ipc call launcher toggle";
          "Mod+Shift+R".action = sh "noctalia-shell ipc call launcher command";
          "MoD+Ctrl+C".action  = sh "noctalia-shell ipc call launcher clipboard";
        }
        { # Audio keys
          "XF86AudioMute".action        = sh "noctalia-shell ipc call volume muteOutput";
          "XF86AudioRaiseVolume".action = sh "noctalia-shell ipc call volume increase";
          "XF86AudioLowerVolume".action = sh "noctalia-shell ipc call volume decrease";
        }
      ];
    };
  };
}
