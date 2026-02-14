{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
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