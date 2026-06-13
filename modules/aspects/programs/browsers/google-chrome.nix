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
            defaultApplications = (
              let
                application = "google-chrome.desktop";
                mimeTypes = [
                  "text/html"
                  "application/rdf+xml"
                  "application/rss+xml"
                  "application/xhtml+xml"
                  "application/xhtml_xml"
                  "x-scheme-handler/http"
                  "x-scheme-handler/https"
                  "x-scheme-handler/about"
                  "x-scheme-handler/mailto"
                  "x-scheme-handler/unknown"
                  "x-scheme-handler/google-chrome"
                ];
              in
              lib.genAttrs mimeTypes (mimetype: application)
            );
            associations.added =
              let
                application = "google-chrome.desktop";
                mimeTypes = [
                  "application/xml"
                  "application/pdf"
                  "text/markdown"
                  "text/xml"
                  "image/jpeg"
                  "image/webp"
                  "image/gif"
                  "image/png"
                ];
              in
              lib.genAttrs mimeTypes (mimetype: application);
          };
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          {
            # "~/.config/google-chrome"
            directory = "${hmConfig.xdg.configHome}/google-chrome";
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
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/google-chrome"
          "${hmConfig.xdg.cacheHome}/google-chrome"
        ];
      };
  };
}
