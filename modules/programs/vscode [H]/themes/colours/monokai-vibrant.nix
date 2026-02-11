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
            colorTheme = "Monokai Vibrant";
          };
        };

        extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "monokai-vibrant";
            publisher = "s3gf4ult";
            version = "0.5.3";
            sha256 = "sha256-uh/yc8kmUW6hgNysQKcs3XPCtcR0o6qvshJM5tXFFws=";
          }
        ];
      };
    };
  };
}