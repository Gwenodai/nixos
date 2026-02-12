{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          bashIde ={
            shellcheckPath = "${pkgs.shellcheck}/bin/shellcheck";
            # TODO: To get documentation for flags on hover, setup and configure explainshell
            explainshellEndpoint = ""; # Disable explainshell
            shfmt.path = "";           # Disable shfmt
          };
        };

        extensions = with pkgs.vscode-extensions; [
          mads-hartmann.bash-ide-vscode # Bash LSP for an IDE-like experience
        ];
      };
    };

    home.packages = with pkgs; [
      shellcheck # Shell script analysis tool - Needed for bash-ide-vscode
    ];
  };
}