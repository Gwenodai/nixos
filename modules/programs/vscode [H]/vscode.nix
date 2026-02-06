# https://mynixos.com/home-manager/options/programs.vscode
# https://mynixos.com/nixpkgs/packages/vscode-extensions
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      enable = true;
      profiles.default = {
        userSettings = {
          # Settings here
        };

        extensions = with pkgs.vscode-extensions; [
          # vscode extensions here
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # kisstkondoros.vscode-gutter-preview # Simple example
          # { # Example marketplace extenstion
          #   name = "remote-ssh-edit";
          #   publisher = "ms-vscode-remote";
          #   version = "0.47.2";
          #   sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
          # }
        ];
      };
    };
  };
}