# https://github.com/oxalica/nil/blob/main/docs/configuration.md
{
  den.aspects.vscode.config = {
    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [
          nil # Nix language server (Needed for nix-ide)
          nixfmt
        ];

        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            # Syntax highlighting, formatting, etc
            jnoortheen.nix-ide
            # Syntax highlighting inside shellhooks
            jeff-hykin.better-nix-syntax
            # Syntax highlighting for embedded languages inside Nix multi-line strings
            coopermaruyama.nix-embedded-languages
          ];

          userSettings = {
            nix = {
              enableLanguageServer = true;
              serverPath = "${lib.getExe pkgs.nil}";
              serverSettings = {
                nil = {
                  formatting.command = [ "nixfmt" ];
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

            editor = {
              formatOnSave = true;
              formatOnPaste = true;
            };
          };
        };
      };
  };
}
