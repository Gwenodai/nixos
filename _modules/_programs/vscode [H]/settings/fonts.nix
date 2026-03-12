{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    lib,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          editor = inputs.self.lib.applyDefaults {
            # Single quotes are required for font names with spaces
            fontFamily = lib.concatStringsSep ", " [
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