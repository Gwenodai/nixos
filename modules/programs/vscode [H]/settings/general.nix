{ inputs, ... }: {
  den.aspects.vscode._.settings = {
    _.general = {
      homeManager = { lib, ... }: {
        programs.vscode.profiles.default = {
          userSettings = inputs.self.lib.applyDefaultsRecursive {
            workbench = {
              settings.alwaysShowAdvancedSettings = true;
              startupEditor = "none"; # Disable the welcome page
            };
            
            # Disable vscode/extension updates (This is handled by nix)
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
  };
}
