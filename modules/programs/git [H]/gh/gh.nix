{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.git = {
    lib,
    ...
  }: {
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = lib.mkDefault true;
      };
    };
  };
}