{
  den.aspects.vscode.config = {
    homeManager =
      { pkgs, ... }:
      {
        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            # Massively improves VS Code's built-in markdown preview
            shd101wyy.markdown-preview-enhanced
            # Adds :emoji: syntax support to VS Code's built-in Markdown preview
            bierner.markdown-emoji
          ];

          userSettings.markdown-preview-enhanced = {
            previewColorScheme = "systemColorScheme";
            previewTheme = "atom-dark.css";
            useGitHubStylePipedLink = true;
            mermaidTheme = "dark";
            codeBlockTheme = "monokai.css";
            breakOnSingleNewLine = false;
          };
        };
      };

    ### Persist config
    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/crossnote"
          "${hmConfig.xdg.configHome}/crossnote"
        ];
      };
  };
}
