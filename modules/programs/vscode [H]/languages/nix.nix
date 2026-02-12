{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          nix ={
            enableLanguageServer = true;
            serverPath = "${pkgs.nil}/bin/nil";
          };
        };

        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide           # Syntax highlighting, formatting, etc
          jeff-hykin.better-nix-syntax # Syntax highlighting inside shellhooks
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          { # Syntax highlighting for embedded languages inside Nix multi-line strings
            name = "nix-embedded-languages";
            publisher = "coopermaruyama";
            version = "1.1.1";
            sha256 = "sha256-2VLX030Zc3kl6vozLr2cbcCREoDH6gywUHQqhNVb1G4=";
          }
        ];
      };
    };

    home.packages = with pkgs; [
      nil # Nix language server - Needed for nix-ide
    ];
  };
}