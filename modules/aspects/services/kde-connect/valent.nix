{ den, ... }:
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

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/valent";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
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
        "${hmConfig.xdg.configHome}" = { }; # "~/.config
        "${hmConfig.xdg.cacheHome}" = { }; # "~/.cache
      };
  };
}
