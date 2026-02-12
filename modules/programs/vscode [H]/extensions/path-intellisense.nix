# Plugin that autocompletes filenames
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          christian-kohler.path-intellisense
        ];
      };
    };
  };
}