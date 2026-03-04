{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.messenger = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [ pkgs.caprine ];
  };
}