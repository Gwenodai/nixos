{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          editor = {
            bracketPairColorization = {
              enabled = true;
              independentColorPoolPerBracketType = false;
            };
            
            guides = {
              bracketPairs = "active";
            };

            insertSpaces = true;
            indentSize = "tabsize";
            tabSize = 2;

            wordWrap = "on";
            # wordWrapColumn = 80;
            wrapOnEscapedLineFeeds = false;
          };
        };
      };
    };
  };
}