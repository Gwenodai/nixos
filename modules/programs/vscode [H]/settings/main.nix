{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          workbench = {
            settings.alwaysShowAdvancedSettings = true;
            startupEditor = "none";
          };
          
          update.mode = "none";
          security.workspace.trust.enabled = false;

          extensions = {
            autoUpdate = false;
          };
          
          # experimentalGpuAcceleration = "on";
        };
      };
    };
  };
}