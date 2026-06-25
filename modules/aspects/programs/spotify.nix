{
  den.aspects.spotify = {
    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [
          spotify
          spotify-tray
        ];

        services.playerctld.enable = true;

        xdg = {
          mimeApps = {
            defaultApplications =
              let
                application = "spotify.desktop";
                mimeTypes = [
                  "x-scheme-handler/spotify"
                ];
              in
              lib.genAttrs mimeTypes (_: application);
          };
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/spotify"
          {
            directory = "${hmConfig.xdg.configHome}/spotify";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.cache/spotify"
          {
            directory = "${hmConfig.xdg.cacheHome}/spotify";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.cache"
        "${hmConfig.xdg.cacheHome}" = { };
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
      };
  };
}
