{ inputs, den, ... }:
{
  den.aspects.vscode._.settings._.source-control = den.lib.perUser {
    homeManager =
      { lib, ... }:
      {
        programs.vscode.profiles.default = {
          userSettings = inputs.self.lib.applyDefaultsRecursive {
            # Set source control to tree view for easier parsability
            scm.defaultViewMode = "tree";

            diffEditor = {
              renderSideBySide = false;
              experimental = {
                useTrueInlineView = true;
                showMoves = false;
              };
              hideUnchangedRegions.enabled = false;
              ignoreTrimWhitespace = false;
            };

            git.untrackedChanges = "separate";
            github.gitProtocol = "ssh";
          };
        };
      };
  };
}
