# https://mynixos.com/home-manager/options/programs.kitty
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.kitty = {
    config,
    ...
  }: {
    programs.kitty = {
      enable = true;
      shellIntegration = {
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
      enableGitIntegration = true;
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