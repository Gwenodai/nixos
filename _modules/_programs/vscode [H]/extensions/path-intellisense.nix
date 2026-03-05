# Plugin that autocompletes filenames
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
        extensions = with vscode-marketplace; [
          christian-kohler.path-intellisense
        ];
      };
    };
  };
}