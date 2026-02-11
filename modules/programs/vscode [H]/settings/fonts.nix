{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          editor = {
            # Single quotes inside double quotes are required for font names with spaces
            fontFamily = builtins.concatStringsSep ", " [
              "'JetBrainsMono Nerd Font'"
              "'Droid Sans Mono'"
              "monospace"
            ];
            # Combines multiple characters into a single unique character '!'+'=' = '≠'
            fontLigatures = true;
          };
        };
      };
    };
  };
}