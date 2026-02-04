# TODO: Configure bash
# https://mynixos.com/home-manager/options/programs.bash
{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.shell = { ... }: {
    programs.bash = {
      enable = true;
      enableCompletion = true;
    };
  };
}