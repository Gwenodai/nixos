{ den, ... }:
let
  bash = {
    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [ shellcheck ]; # Shell script analysis tool

        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            mads-hartmann.bash-ide-vscode # Bash LSP for an IDE-like experience
          ];

          userSettings.bashIde = {
            shellcheckPath = "${lib.getExe pkgs.shellcheck}";
            # TODO: To get documentation for flags on hover, setup and configure explainshell
            explainshellEndpoint = ""; # Disable explainshell
            shfmt.path = ""; # Disable shfmt
          };
        };
      };
  };
in
{
  den.aspects.vscode._.config.includes = [
    bash
  ];
}
