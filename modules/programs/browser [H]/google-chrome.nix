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
        defaultApplications =
          let
            browser = "google-chrome.desktop";

            browserAssociations = [
              "text/html"
              "x-scheme-handler/http"
              "x-scheme-handler/https"
              "x-scheme-handler/about"
              "x-scheme-handler/unknown"
            ];
          in
          lib.genAttrs browserAssociations (x: browser);
      };
    };
  };
}