{
  den.aspects.google-chrome = {
    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [
          google-chrome
        ];

        xdg = {
          mimeApps = {
            defaultApplications =
              let
                application = "google-chrome.desktop";
                mimeTypes = [
                  "application/pdf"
                  "application/rdf+xml"
                  "application/rss+xml"
                  "application/xhtml+xml"
                  "application/xhtml_xml"
                  "application/xml"
                  "image/gif"
                  "image/jpeg"
                  "image/png"
                  "image/webp"
                  "text/html"
                  "text/xml"
                  "x-scheme-handler/http"
                  "x-scheme-handler/https"
                  "x-scheme-handler/google-chrome"
                ];
              in
              lib.genAttrs mimeTypes (_: application);
            associations.added =
              let
                application = "google-chrome.desktop";
                mimeTypes = [
                  "text/markdown"
                  "x-scheme-handler/mailto"
                  "x-scheme-handler/about"
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
          # "~/.config/google-chrome"
          {
            directory = "${hmConfig.xdg.configHome}/google-chrome";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
          # "~/.cache/google-chrome"
          {
            directory = "${hmConfig.xdg.cacheHome}/google-chrome";
            how = "symlink";
            mode = "0700";
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
