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

        xdg.mimeApps = {
          defaultApplications =
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

              application2 = "code-url-handler.desktop";
              mimeTypes2 = [
                "x-scheme-handler/vscode"
              ];
            in
            lib.genAttrs mimeTypes (_: application) // lib.genAttrs mimeTypes2 (_: application2);
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/Code"
          {
            directory = "${hmConfig.xdg.configHome}/Code";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.vscode-shared/sharedStorage"
          {
            directory = "${hmConfig.home.homeDirectory}/.vscode-shared/sharedStorage";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
        files = [
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
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
        # "~/.vscode"
        "${hmConfig.home.homeDirectory}/.vscode" = { };
        # "~/.vscode-shared"
        "${hmConfig.home.homeDirectory}/.vscode-shared" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.local/state/.copilot/ide"
          "${hmConfig.xdg.stateHome}/.copilot/ide"
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
