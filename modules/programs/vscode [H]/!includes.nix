{ den, ... }: {
  den.aspects.vscode = {
    includes = with den.aspects.vscode._; [
      enable
      settings
      languages
      
      # ---Extensions--- #
      extensions._.todo-highlight
      extensions._.path-intellisense

      # ---Themes--- #
      themes._.colours._.monokai-vibrant
      themes._.icons._.symbols
      {
        homeManager = { lib, ... }: {
          programs.vscode.profiles.default.userSettings.workbench = {
            # DON'T FORGET TO SET DEFAULT THEME SETTINGS HERE
            colorTheme = lib.mkDefault "Monokai Vibrant";
            iconTheme = lib.mkDefault "symbols";
          };
        };
      }
    ];
  };
}
