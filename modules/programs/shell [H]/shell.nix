{
  flake.modules.homeManager.shell = {
    config,
    ...
  }: {
    # Custom Aliases
    home.shellAliases = {
      ll = "eza -Al --icons --group-directories-first";
      ls = "eza -A --icons --group-directories-first";
      cat = "bat";
    };

    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
    };
  };
}