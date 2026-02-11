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
            # TODO: To get documentation for flags on hover, setup up and configure explainshell
            explainshellEndpoint = ""; # Disable explainshell
            shfmt.path = ""; # Disable shfmt
          };
        };

        extensions = with pkgs.vscode-extensions; [
          mads-hartmann.bash-ide-vscode # Bash LSP that brings an IDE-like experience
        ];
      };
    };

    home.packages = with pkgs; [
      shellcheck # Shell script analysis tool - Needed for bash-ide-vscode
    ];
  };
}