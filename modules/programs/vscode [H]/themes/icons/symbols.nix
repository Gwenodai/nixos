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
            iconTheme = "symbols";
          };
        };

        extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "symbols";
            publisher = "miguelsolorio";
            version = "0.0.25";
            sha256 = "sha256-nhymeLPfgGKyg3krHqRYs2iWNINF6IFBtTAp5HcwMs8=";
          }
        ];
      };
    };
  };
}