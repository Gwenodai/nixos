{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.browser = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = with pkgs; [
      google-chrome
    ];

    xdg = {
      mimeApps = {
        defaultApplications = lib.mkBefore (
          let
            application = "google-chrome.desktop";

            mimeTypes = [
              "text/html"
              "application/pdf"
              "x-scheme-handler/http"
              "x-scheme-handler/https"
              "x-scheme-handler/about"
              "x-scheme-handler/mailto"
              "x-scheme-handler/unknown"
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application)
        );
        associations.added =
          let
            application = "google-chrome.desktop";

            mimeTypes = [
              "text/markdown"
              "application/pdf"
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application);
      };
    };
  };
}