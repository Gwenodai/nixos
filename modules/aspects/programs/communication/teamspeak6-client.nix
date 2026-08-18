{
  den.aspects.teamspeak6-client = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.teamspeak6-client ];
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/TeamSpeak"
          {
            directory = "${hmConfig.xdg.configHome}/TeamSpeak";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.cache/TeamSpeak"
          {
            directory = "${hmConfig.xdg.cacheHome}/TeamSpeak";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
        # "~/.cache"
        "${hmConfig.xdg.cacheHome}" = { };
      };
  };
}
