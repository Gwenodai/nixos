{
  inputs,
  den,
  ...
}:
let
  extensions = {
    nixos.hostConfig.vscode.extensions.enable = true;

    homeManager =
      { pkgs, ... }:
      {
        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            jgclark.vscode-todo-highlight # Highlights TODOs, FIXMEs, etc.
            christian-kohler.path-intellisense # Autocompletes filenames
            github.vscode-github-actions # GitHub Actions workflows and runs
          ];

          userSettings.todohighlight = {
            # Whitelisted files to highlight
            includes = [
              "**/*.md"
              "**/*.sh"
              "**/*.nix"
              "**/*.kdl"
              "**/*.json"
            ];
          };
        };
      };
  };
in
{
  flake-file.inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Host specific extension overlay logic to prevent duplicate overlays
  den.ctx.host.nixos =
    { config, lib, ... }:
    {
      options.hostConfig.vscode.extensions.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable vscode extension overlay";
      };

      config = lib.mkIf config.hostConfig.vscode.extensions.enable {
        nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
      };
    };

  den.aspects.vscode._.config.includes = [
    extensions
  ];
}
