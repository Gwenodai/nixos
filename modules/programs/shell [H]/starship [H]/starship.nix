{
  # TODO: Configure starship
  # https://mynixos.com/home-manager/options/programs.starship
  flake.modules.homeManager.shell = { ... }: {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = false;
      };
    };
  };
}