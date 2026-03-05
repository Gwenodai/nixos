# TODO: Configure bash
# https://mynixos.com/home-manager/options/programs.bash
{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.shell = {
    lib,
    ...
  }: {
    programs.bash = {
      enable = lib.mkDefault true;
      enableCompletion = lib.mkDefault true;
    };
  };
}