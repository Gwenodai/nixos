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
        userSettings = {
          editor = inputs.self.lib.applyDefaultsRecursive {
            # -BRACKETS-
            guides.bracketPairs = "active";
            bracketPairColorization = {
              enabled = true;
              independentColorPoolPerBracketType = false;
            };

            # -INDENTATION-
            insertSpaces = true;
            indentSize = "tabsize";
            tabSize = 2;

            # -WRAPPING-
            wordWrap = "on";
            # wordWrapColumn = 80;
            wrapOnEscapedLineFeeds = false;
          };
        };
      };
    };
  };
}