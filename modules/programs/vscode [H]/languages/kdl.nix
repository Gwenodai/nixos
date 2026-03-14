{ den, ... }: {
  den.aspects.vscode._.languages = {
    _.kdl = {
      includes = [ den.aspects.vscode._.extensions ];
      homeManager = { pkgs, ... }: {
        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            kdl-org.kdl
          ];

          userSettings.nix-embedded-languages.include = {
            kdl = "source.kdl";
          };
        };
      };
    };
  };
}
