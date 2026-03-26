{ den, ... }: {
  den.aspects.vscode._.languages._.toml = den.lib.perUser {
    includes = [ den.aspects.vscode._.extensions._.enable ];
    homeManager = { pkgs, lib, ... }: {
      programs.vscode.profiles.default = {
        extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
          tamasfe.even-better-toml
        ];
        userSettings = {
          evenBetterToml = {
            schema.links = lib.mkDefault true; # Show clickable links in editor
          };
          
          nix-embedded-languages.include = {
            toml = "source.toml";
          };
        };
      };
    };
  };
}
