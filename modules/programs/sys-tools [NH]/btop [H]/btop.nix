{
  # Resource monitor
  flake.modules.homeManager.sys-tools = { ... }: {
    programs.btop = {
      enable = true;
      # TODO: Configure btop
      # https://mynixos.com/home-manager/options/programs.btop
    };
  };
}