{ den, ... }:
let
  toml = den.lib.perUser {
    homeManager =
      { pkgs, lib, ... }:
      {
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
in
{
  den.aspects.vscode._.config.includes = [
    toml
  ];
}
