# https://mynixos.com/home-manager/options/programs.vscode
{ inputs, ... }:
{
  flake-file.inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.vscode = {
    nixos = {
      nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
    };

    homeManager =
      { lib, ... }:
      {
        programs.vscode.enable = true;

        xdg.mimeApps.defaultApplications = (
          let
            application = "code.desktop";
            mimeTypes = [
              "application/octet-stream"
              "application/x-executable"
              "application/x-object"
              "application/x-shellscript"
              "application/x-zerosize"
              "application/xml"
              "text/css"
              "text/javascript"
              "text/markdown"
              "text/plain"
              "text/x-csrc"
              "text/x-python"
              "text/x-python3"
              "text/csv"
              "text/x-nix"
              "text/plain"
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application)
        );
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/Code/User"
          "${hmConfig.xdg.configHome}/Code/User"
        ];
        files = [
          # "~/.config/Code/Trust Tokens"
          {
            file = "${hmConfig.xdg.configHome}/Code/Trust Tokens";
            mode = "0600";
          }
          # "~/.config/Code/Trust Tokens-journal"
          {
            file = "${hmConfig.xdg.configHome}/Code/Trust Tokens-journal";
            mode = "0600";
          }
          # "~/.vscode/argv.json"
          {
            file = "${hmConfig.home.homeDirectory}/.vscode/argv.json";
            mode = "0644";
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.config/Code"
        "${hmConfig.xdg.configHome}" = { };
        "${hmConfig.xdg.configHome}/Code" = { };
        # "~/.vscode"
        "${hmConfig.home.homeDirectory}/.vscode" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/Code"
          "${hmConfig.xdg.configHome}/Code"
        ];
        files = [
          # "~/.cache/Microsoft/DeveloperTools/deviceid"
          "${hmConfig.xdg.cacheHome}/Microsoft/DeveloperTools/deviceid"
          # "~/.vscode/extensions/extensions.json"
          ".vscode/extensions/extensions.json"
        ];
      };
  };
}
