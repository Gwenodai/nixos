{ inputs, den, ... }: {
  den.aspects.vscode._.languages._.markdown = den.lib.perUser {
    includes = [ den.aspects.vscode._.extensions._.enable ];
    homeManager = { pkgs, ... }: {
      programs.vscode.profiles.default = {
        extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
          # Massively improves VS Code's built-in markdown preview
          shd101wyy.markdown-preview-enhanced
          # Adds :emoji: syntax support to VS Code's built-in Markdown preview
          bierner.markdown-emoji

          # # Changes VS Code's built-in markdown preview to match GitHub's styling
          # bierner.markdown-preview-github-styles
          # # Adds Mermaid diagram and flowchart support to VS Code's builtin markdown preview
          # bierner.markdown-mermaid
          # # Adds checkbox support to the built-in markdown preview
          # bierner.markdown-checkbox
        ];

        userSettings.markdown-preview-enhanced = inputs.self.lib.applyDefaults {
          previewColorScheme = "systemColorScheme";
          previewTheme = "atom-dark.css";
          useGitHubStylePipedLink = true;
          mermaidTheme = "dark";
          codeBlockTheme = "monokai.css";
          breakOnSingleNewLine = false;
        };
      };
    };

    persistUserIgnore = { hmConfig, ... }: {
      directories = [ "${hmConfig.xdg.configHome}/crossnote" ];
    };
  };
}
