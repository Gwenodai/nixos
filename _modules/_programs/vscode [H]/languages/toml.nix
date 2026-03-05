# Fully-featured TOML support
{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    vscode-marketplace,
    lib,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        userSettings = {
          evenBetterToml = {
            schema.links = lib.mkDefault true; # Show clickable links in editor
          };
          
          nix-embedded-languages.include = {
            toml = "source.toml";
          };
        };

        extensions = with vscode-marketplace; [
          tamasfe.even-better-toml
        ];
      };
    };
  };
}