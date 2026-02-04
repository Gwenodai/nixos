{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.git = { ... }: {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
      };
    };
  };
}