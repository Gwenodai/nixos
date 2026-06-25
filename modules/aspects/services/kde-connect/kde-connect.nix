# TODO: Finish this aspect, and add a persistUser config for it.
{
  den.aspects.kde-connect = {
    nixos = {
      programs.kdeconnect.enable = true;
    };

    homeManager = {
      services.kdeconnect = {
        enable = true;
        indicator = true;
      };
    };

    ### Persist config
    # persistUser =
    #   { hmConfig, ... }:
    #   {
    #     directories = [
    #       # "~/.config/valent"
    #       {
    #         directory = "${hmConfig.xdg.configHome}/valent";
    #         mode = "0700";
    #         how = "symlink";
    #         createLinkTarget = true;
    #       }
    #       # "~/.cache/valent"
    #       {
    #         directory = "${hmConfig.xdg.cacheHome}/valent";
    #         mode = "0700";
    #         how = "symlink";
    #         createLinkTarget = true;
    #       }
    #     ];
    #   };
    # persistUserTmp =
    #   { hmConfig, ... }:
    #   {
    #     # "~/.config"
    #     "${hmConfig.xdg.configHome}" = { };
    #     # "~/.cache"
    #     "${hmConfig.xdg.cacheHome}" = { };
    #   };
  };
}
