{ den, ... }: {
  den.aspects.vscode.includes = with den.aspects.vscode._; [
    enable
    settings
    languages
    extensions
    # ---Themes--- #
    themes._.colours._.monokai-vibrant
    themes._.icons._.symbols
    # Theme config
    ( den.lib.perUser {
      homeManager = { lib, ... }: {
        programs.vscode.profiles.default.userSettings.workbench = {
          # DON'T FORGET TO SET DEFAULT THEME SETTINGS HERE
          colorTheme = lib.mkDefault "Monokai Vibrant";
          iconTheme = lib.mkDefault "symbols";
        };
      };
    })
  ];
}
