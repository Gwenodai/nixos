{ inputs, den, ... }: {
  den.aspects.vscode._.settings._.formatting = den.lib.perUser {
    homeManager = { lib, ... }: {
      programs.vscode.profiles.default.userSettings = {
        editor = inputs.self.lib.applyDefaultsRecursive {
          # ---Brackets--- #
          guides.bracketPairs = "active";
          bracketPairColorization = {
            enabled = true;
            independentColorPoolPerBracketType = false;
          };

          # ---Indentation--- #
          insertSpaces = true;
          indentSize = "tabsize";
          tabSize = 2;

          # ---Wrapping--- #
          wordWrap = "on";
          # wordWrapColumn = 80;
          wrapOnEscapedLineFeeds = false;
        };
      };
    };
  };
}
