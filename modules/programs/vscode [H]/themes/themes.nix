{ den, ... }: {
  den.aspects.vscode._.themes = {
    _.colours = {
  # ---Colours--- #
      _.monokai-vibrant = {
        includes = [ den.aspects.vscode._.extensions ];
        homeManager = { pkgs, lib, ... }: {
          programs.vscode.profiles.default = {
            extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
              s3gf4ult.monokai-vibrant
            ];
          };
        };
      };
    };

    _.icons = {
  # ---Icons--- #
      _.catppuccin-vsc-icons = {
        includes = [ den.aspects.vscode._.extensions ];
        homeManager = { pkgs, lib, ... }: {
          programs.vscode.profiles.default = {
            extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
              catppuccin.catppuccin-vsc-icons
            ];
            # Icon options: mocha, latte, frappe, macchiato
            # Used like "catppuccin-mocha" or "catppuccin-latte" ...
          };
        };
      };

      _.symbols = {
        includes = [ den.aspects.vscode._.extensions ];
        homeManager = { pkgs, lib, ... }: {
          programs.vscode.profiles.default = {
            extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
              miguelsolorio.symbols
            ];
          };
        };
      };
    };
  };
}
