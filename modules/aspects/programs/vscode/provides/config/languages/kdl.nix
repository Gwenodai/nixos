{ den, ... }:
let
  kdl = {
    homeManager =
      { pkgs, ... }:
      {
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
in
{
  den.aspects.vscode._.config.includes = [
    kdl
  ];
}
