{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          editor = {
            # Single quotes are required for font names with spaces
            fontFamily = builtins.concatStringsSep ", " [
              "'JetBrainsMono Nerd Font'"
              "'Droid Sans Mono'"
              "monospace"
            ];
            # Combines multiple characters '!'+'='becomes '≠'
            fontLigatures = true;
          };
        };
      };
    };
  };
}