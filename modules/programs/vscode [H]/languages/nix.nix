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
            # serverSettings = {
            #   nil = {
            #     command = [ "${pkgs.nil}/bin/nil" ];
            #   };
            # };
          };
        };

        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide # Syntax highlighting, formatting, and error reporting
          jeff-hykin.better-nix-syntax # Syntax highlighting inside shellhooks
        ];
      };
    };

    home.packages = with pkgs; [
      nil # Nix language server - Needed for nix-ide
    ];
  };
}