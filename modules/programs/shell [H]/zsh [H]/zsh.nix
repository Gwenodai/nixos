{
  # TODO: Configure zsh
  # https://mynixos.com/home-manager/options/programs.zsh
  flake.modules.homeManager.shell = {
    config,
    ...
  }: {
    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
    };
  };
}