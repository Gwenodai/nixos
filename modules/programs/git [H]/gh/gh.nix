{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.git = {
    lib,
    ...
  }: {
    programs.gh = {
      enable = lib.mkDefault true;
      gitCredentialHelper = {
        enable = lib.mkDefault true;
      };
    };
  };
}