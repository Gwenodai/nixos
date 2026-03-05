{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.git = {
    lib,
    ...
  }: {
    programs.git = {
      enable = lib.mkDefault true;
      settings = {
        init.defaultBranch = lib.mkDefault  "main";
      };
    };
  };
}