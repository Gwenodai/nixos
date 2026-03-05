# Highlights TODOs, FIXMEs, etc.
{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    vscode-marketplace,
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

        extensions = with vscode-marketplace; [
          jgclark.vscode-todo-highlight
        ];
      };
    };
  };
}