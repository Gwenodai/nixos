{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          scm = {
            defaultViewMode = "tree";
          };
          
          diffEditor = {
            renderSideBySide = false;

            experimental = {
              useTrueInlineView = true;
              showMoves = false;
            };
          };

          git.untrackedChanges = "separate";
          github.gitProtocol = "ssh";
        };
      };
    };
  };
}