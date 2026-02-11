# https://mynixos.com/home-manager/options/programs.vscode
# https://mynixos.com/nixpkgs/packages/vscode-extensions
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    # pkgs,
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
  };
}