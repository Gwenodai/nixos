{
  den.aspects.vscode.config = {
    homeManager =
      { pkgs, ... }:
      {
        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            # Highlights TODOs, FIXMEs, etc.
            jgclark.vscode-todo-highlight
            # Autocompletes filenames
            christian-kohler.path-intellisense
            # GitHub Actions workflows and runs
            github.vscode-github-actions
          ];

          userSettings.todohighlight = {
            # todo-highlight allowlist
            include = [
              "**/*.js"
              "**/*.jsx"
              "**/*.ts"
              "**/*.tsx"
              "**/*.html"
              "**/*.css"
              "**/*.scss"
              "**/*.php"
              "**/*.rb"
              "**/*.txt"
              "**/*.mdown"
              "**/*.md"
              "**/*.sh"
              "**/*.nix"
              "**/*.kdl"
              "**/*.json"
            ];
            # todo-highlight keywords
            keywords = [
              {
                text = "TODO:";
                color = "#fff";
                backgroundColor = "#ffbd2a";
                overviewRulerColor = "rgba(255,189,42,0.8)";
              }
              {
                text = "FIXME:";
                color = "#fff";
                backgroundColor = "#f06292";
                overviewRulerColor = "rgba(240,98,146,0.8)";
              }
              {
                text = "NOTE:";
                color = "#fff";
                backgroundColor = "#ffbd2a";
                overviewRulerColor = "rgba(255,189,42,0.8)";
              }
            ];
          };
        };
      };
  };
}
