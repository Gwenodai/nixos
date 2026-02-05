# https://mynixos.com/home-manager/options/programs.kitty
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.kitty = {
    pkgs,
    ...
  }: {
    programs.kitty = {
      enable = true;

      shellIntegration = {
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
      enableGitIntegration = true;
      font = {
        name = "JetBrainsMono Nerd Font Mono";
        package = pkgs.nerd-fonts.jetbrains-mono;
        # size = "8";
      };
      settings = {
        background_opacity = 0.4;
        background = "#000000";
      };
    };

    # Custom aliases
    home.shellAliases = {
      ssh = "kitty +kitten ssh";
    };
  };
}