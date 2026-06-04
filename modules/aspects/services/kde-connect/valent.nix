{
  den.aspects.valent = {
    nixos =
      { pkgs, ... }:
      {
        programs.kdeconnect = {
          enable = true;
          package = pkgs.valent;
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/valent"
          {
            directory = "${hmConfig.xdg.configHome}/valent";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.cache/valent"
          {
            directory = "${hmConfig.xdg.cacheHome}/valent";
            mode = "0700";
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
