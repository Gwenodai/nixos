# https://mynixos.com/home-manager/options/programs.vscode
# https://mynixos.com/nixpkgs/packages/vscode-extensions
{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    lib,
    ...
  }: {
    # Create a short way of declaring extensions within home manager modules
    _module.args.vscode-marketplace = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace-release;

    programs.vscode = {
      enable = true;
    };

    xdg = {
      mimeApps = {
        defaultApplications = lib.mkBefore (
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
    };
  };
}