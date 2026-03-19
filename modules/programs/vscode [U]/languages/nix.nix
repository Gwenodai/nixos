# https://github.com/oxalica/nil/blob/main/docs/configuration.md
{ inputs, den, ... }: {
  den.aspects.vscode._.languages._.nix = den.lib.perUser {
    includes = [ den.aspects.vscode._.extensions ];
    homeManager = { pkgs, lib, ... }: {
      home.packages = with pkgs; [ nil ]; # Nix language server (Needed for nix-ide)
      programs.vscode.profiles.default = {
        extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
          # Syntax highlighting, formatting, etc
          jnoortheen.nix-ide
          # Syntax highlighting inside shellhooks
          jeff-hykin.better-nix-syntax
          # Syntax highlighting for embedded languages inside Nix multi-line strings
          coopermaruyama.nix-embedded-languages
        ];
        userSettings.nix = inputs.self.lib.applyDefaultsRecursive {
          enableLanguageServer = true;
          serverPath = "${lib.getExe pkgs.nil}";
          serverSettings = {
            nil = {
              formatting.command = null;
              # diagnostics.ignored = [ "unused_with" ];
              nix = {
                binary = "/run/current-system/sw/bin/nix";
                maxMemoryMB = 16384;
                flake = {
                  autoArchive = null;
                  autoEvalInputs = true;
                  nixpkgsInputName = "nixpkgs";
                };
              };
            };
          };
          # Hide annoying popups triggered during typing code
          hiddenLanguageServerErrors = [
            "textDocument/formatting"
            "textDocument/documentSymbol"
          ];
        };
      };
    };
  };
}
