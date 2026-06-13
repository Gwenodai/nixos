{
  den.aspects.vscode.config = {
    homeManager =
      { pkgs, ... }:
      {
        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            s3gf4ult.monokai-vibrant
            miguelsolorio.symbols
          ];

          userSettings.workbench = {
            colorTheme = "Monokai Vibrant";
            iconTheme = "symbols";
          };
        };
      };
  };
}
