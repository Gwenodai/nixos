# Fully-featured TOML support
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          evenBetterToml = {
            schema.links = true; # Show clickable links in editor
          };
          
          nix-embedded-languages.include = {
            toml = "source.toml";
          };
        };

        extensions = with pkgs.vscode-extensions; [
          tamasfe.even-better-toml
        ];
      };
    };
  };
}