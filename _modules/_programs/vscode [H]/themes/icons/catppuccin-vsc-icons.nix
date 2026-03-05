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
            # "catppuccin-..." options are: mocha, latte, frappe, macchiato
            iconTheme = lib.mkOptionDefault "catppuccin-mocha";
          };
        };

        extensions = with vscode-marketplace; [
          catppuccin.catppuccin-vsc-icons
        ];
      };
    };
  };
}