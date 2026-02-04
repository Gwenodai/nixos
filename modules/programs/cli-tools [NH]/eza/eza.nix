# A modern replacement for 'ls'
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.cli-tools = { ... }: {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      icons = "always";
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
  };
}