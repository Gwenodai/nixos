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
            colorTheme = lib.mkDefault "Monokai Vibrant";
          };
        };

        extensions = with vscode-marketplace; [
          s3gf4ult.monokai-vibrant
        ];
      };
    };
  };
}