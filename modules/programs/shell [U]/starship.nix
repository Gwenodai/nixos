{ den, ... }:
{
  # TODO: Configure starship
  # https://mynixos.com/home-manager/options/programs.starship
  den.aspects.shell._.starship = den.lib.perUser {
    homeManager =
      { lib, ... }:
      {
        programs.starship = {
          enable = lib.mkDefault true;
          enableBashIntegration = lib.mkDefault true;
          enableZshIntegration = lib.mkDefault true;
          settings = {
            add_newline = lib.mkDefault true;
            aws.disabled = lib.mkDefault true;
            gcloud.disabled = lib.mkDefault true;
            line_break.disabled = lib.mkDefault false;
          };
        };
      };
  };
}
