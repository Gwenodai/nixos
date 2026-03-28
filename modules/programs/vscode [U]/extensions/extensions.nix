{ inputs, den, lib, ... }: {
  flake-file.inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Host specific extension overlay logic to prevent duplicate overlays
  den.ctx.host.nixos = { config, lib, ... }: {
    options.hostConfig.vscode.extensions.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable vscode extension overlay";
    };
    config = lib.mkIf config.hostConfig.vscode.extensions.enable {
      nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
    };
  };
  
  # Enables extensions overlay
  den.aspects.vscode._.extensions = {
    # Bundles all extensions components when the complete 'extensions' sub-aspect is used
    includes = lib.attrValues den.aspects.vscode._.extensions._;

    # This doesn't use `perUser` as it will be included within other `perUser` aspects
    _.enable = {
      nixos.hostConfig.vscode.extensions.enable = true;
    };
    
  # ---Extensions--- #
    # Highlights TODOs, FIXMEs, etc.
    _.todo-highlight = den.lib.perUser {
      includes = [ den.aspects.vscode._.extensions._.enable ];
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
    _.path-intellisense = den.lib.perUser {
      includes = [ den.aspects.vscode._.extensions._.enable ];
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
