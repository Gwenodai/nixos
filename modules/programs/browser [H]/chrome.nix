{ den, ... }: {
  
  den.aspects.browser = {
    includes = with den.aspects.browser.provides; [ chrome ];
    
    provides.chrome = {
      homeManager = { pkgs, lib, ... }: {
        home.packages = with pkgs; [
          google-chrome
        ];

        xdg = {
          mimeApps = {
            defaultApplications = lib.mkBefore (
              let
                application = "google-chrome.desktop";
                mimeTypes = [
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
              in lib.genAttrs mimeTypes (mimetype: application)
            );
            associations.added = let
              application = "google-chrome.desktop";
              mimeTypes = [
                "application/xml"
                "application/pdf"
                "text/markdown"
                "image/jpeg"
                "image/webp"
                "image/gif"
                "image/png"
                "text/html"
                "text/xml"
              ];
            in lib.genAttrs mimeTypes (mimetype: application);
          };
        };
      };

      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/google-chrome";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      };

      persistUserIgnore = { hmConfig, ... }: {
        directories = [ "${hmConfig.xdg.cacheHome}/google-chrome" ];
      };
    };
  };
}
