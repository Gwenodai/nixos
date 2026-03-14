{ inputs, den, ... }: {
  flake-file.inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  
  # Enables extensions
  den.aspects.vscode._.extensions = {
    nixos = {
      nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
    };
    
  # ---Extensions--- #
    # Highlights TODOs, FIXMEs, etc.
    _.todo-highlight = {
      includes = [ den.aspects.vscode._.extensions ];
      homeManager = { pkgs, ... }: {
        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            jgclark.vscode-todo-highlight
          ];

          userSettings.todohighlight = {
            # Whitelisted files to highlight
            include = [
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

    # Plugin that autocompletes filenames
    _.path-intellisense = {
      includes = [ den.aspects.vscode._.extensions ];
      homeManager = { pkgs, ... }: {
        programs.vscode.profiles.default = {
          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
            christian-kohler.path-intellisense
          ];
        };
      };
    };
  };
}
