{ den, ... }: {
  den.aspects.vscode._.themes._.default = den.lib.perUser {
    includes = with den.aspects.vscode._.themes._; [
      icons._.symbols
      colours._.monokai-vibrant
    ];

    homeManager = { lib, ... }: {
      # Default theme config
      programs.vscode.profiles.default.userSettings.workbench = {
        colorTheme = lib.mkDefault "Monokai Vibrant";
        iconTheme = lib.mkDefault "symbols";
      };
    };
  };
}
