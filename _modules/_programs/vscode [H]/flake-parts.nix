# Install vscode marketplace extensions via nix
{
  ...
}: {
  flake-file.inputs = {
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}