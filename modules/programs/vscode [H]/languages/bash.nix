{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    vscode-marketplace,
    pkgs,
    lib,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          bashIde = inputs.self.lib.applyDefaultsToData {
            shellcheckPath = "${(lib.getExe pkgs.shellcheck)}";
            # TODO: To get documentation for flags on hover, setup and configure explainshell
            explainshellEndpoint = ""; # Disable explainshell
            shfmt.path = "";           # Disable shfmt
          };
        };

        extensions = with vscode-marketplace; [
          mads-hartmann.bash-ide-vscode # Bash LSP for an IDE-like experience
        ];
      };
    };

    home.packages = with pkgs; [
      shellcheck # Shell script analysis tool - Needed for bash-ide-vscode
    ];
  };
}