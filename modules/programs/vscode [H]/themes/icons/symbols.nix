{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    vscode-marketplace,
    lib,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          workbench = {
            iconTheme = lib.mkDefault "symbols";
          };
        };

        extensions = with vscode-marketplace; [
          miguelsolorio.symbols
        ];
      };
    };
  };
}