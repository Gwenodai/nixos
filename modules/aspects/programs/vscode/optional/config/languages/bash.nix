{
  den.aspects.vscode.config = {
    homeManager =
      { pkgs, lib, ... }:
      {
        # Shell script analysis tool
        home.packages = with pkgs; [ shellcheck ];

        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            # Bash LSP for an IDE-like experience
            mads-hartmann.bash-ide-vscode
          ];

          userSettings.bashIde = {
            shellcheckPath = "${lib.getExe pkgs.shellcheck}";
            # TODO: To get documentation for flags on hover, setup and configure explainshell
            # Disable explainshell
            explainshellEndpoint = "";
            # Disable shfmt
            shfmt.path = "";
          };
        };
      };
  };
}
