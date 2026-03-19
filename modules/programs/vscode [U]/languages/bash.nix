{ den, ... }: {
  den.aspects.vscode._.languages._.bash = den.lib.perUser {
    includes = [ den.aspects.vscode._.extensions ];
    homeManager = { pkgs, lib, ... }: {
      home.packages = with pkgs; [ shellcheck ]; # Shell script analysis tool
      programs.vscode.profiles.default = {
        extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
          mads-hartmann.bash-ide-vscode # Bash LSP for an IDE-like experience
        ];
        userSettings.bashIde = {
          shellcheckPath = lib.mkDefault "${lib.getExe pkgs.shellcheck}";
          # TODO: To get documentation for flags on hover, setup and configure explainshell
          explainshellEndpoint = lib.mkDefault ""; # Disable explainshell
          shfmt.path = lib.mkDefault "";           # Disable shfmt
        };
      };
    };
  };
}
