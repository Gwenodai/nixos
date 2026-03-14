{ inputs, ... }: {
  den.aspects.vscode._.settings = {
    _.ui = {
      homeManager = { lib, ... }: {
        programs.vscode.profiles.default = {
          userSettings = inputs.self.lib.applyDefaultsRecursive {
            explorer = {
              fileNesting = {
                enabled = true;
                expand = true;
              };
              sortOrder = "foldersNestsFiles";
            };

            workbench = {
              editor.decorations.colors = true;
              list.smoothScrolling = true;
              reduceMotion = "off";
            };

            # Make sure we always use our defined colour schemes
            window = {
              autoDetectColorScheme = false;
              autoDetectHighContrast = false;
            };

            editor = {
              cursorSmoothCaretAnimation = "on";
              cursorBlinking = "phase";
              smoothScrolling = true;
              linkedEditing = true;
            };
          };
        };
      };
    };
  };
}
