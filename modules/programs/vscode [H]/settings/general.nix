{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = inputs.self.lib.applyDefaultsRecursive {
          workbench = {
            settings.alwaysShowAdvancedSettings = true;
            startupEditor = "none"; # Disable the welcome page
          };
          
          # Disable vscode/extension updates (This is handled by vscode module)
          update.mode = "none";
          extensions = {
            autoUpdate = false;
            autoCheckUpdates = false;
          };

          security.workspace.trust.enabled = false;
          # experimentalGpuAcceleration = "on";
        };
      };
    };
  };
}