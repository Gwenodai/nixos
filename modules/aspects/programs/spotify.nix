{ den, ... }:
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
            defaultApplications = (
              let
                application = "spotify.desktop";
                mimeTypes = [
                  "x-scheme-handler/spotify"
                ];
              in
              lib.genAttrs mimeTypes (mimetype: application)
            );
          };
        };
      };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/spotify";
            how = "symlink";
            mode = "0755";
            createLinkTarget = true;
          }
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
        "${hmConfig.xdg.cacheHome}" = { }; # "~/.cache"
        "${hmConfig.xdg.configHome}" = { }; # "~/.config"
      };
  };
}
