# https://mynixos.com/home-manager/options/programs.vscode
# https://mynixos.com/nixpkgs/packages/vscode-extensions
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    # pkgs,
    lib,
    ...
  }: {
    programs.vscode = {
      enable = true;
      profiles.default = {
        # extensions = with pkgs.vscode-extensions; [
        #   # Nixpkgs extenstions
        # ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        #   # Marketplace extenstions
        # ];
      };
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