{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          workbench = {
            iconTheme = "catppuccin-mocha"; # mocha, latte, frappe, macchiato
          };
        };

        extensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc-icons
        ];
      };
    };
  };
}