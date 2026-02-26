{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.git = {
    lib,
    ...
  }: {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = lib.mkDefault  "main";
      };
    };
  };
}