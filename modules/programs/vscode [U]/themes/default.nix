{ den, ... }:
{
  # This doesn't use `perUser` as all of it's inlcudes already do
  den.aspects.vscode._.themes._.default = {
    includes = with den.aspects.vscode._; [
      # Themes used in this config
      themes._.colours._.monokai-vibrant
      themes._.icons._.symbols

      # Configure vscode to use those themes
      (den.lib.perUser {
        homeManager =
          { lib, ... }:
          {
            programs.vscode.profiles.default.userSettings.workbench = {
              colorTheme = lib.mkDefault "Monokai Vibrant";
              iconTheme = lib.mkDefault "symbols";
            };
          };
      })
    ];
  };
}
