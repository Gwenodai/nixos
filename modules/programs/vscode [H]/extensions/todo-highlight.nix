# Highlights TODOs, FIXMEs, etc.
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          todohighlight = {
            # Whitelisted files to highlight
            include = [
              "**/*.md"
              "**/*.sh"
              "**/*.nix"
              "**/*.kdl"
              "**/*.json"
            ];
          };
        };

        extensions = with pkgs.vscode-extensions; [
          jgclark.vscode-todo-highlight
        ];
      };
    };
  };
}