{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
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

          window = {
            autoDetectColorScheme = false;
            autoDetectHighContrast = false;
          };

          editor = {
            cursorBlinking = "phase";
            cursorSmoothCaretAnimation = "on";
            
            smoothScrolling = true;
            linkedEditing = true;
          };
        };
      };
    };
  };
}