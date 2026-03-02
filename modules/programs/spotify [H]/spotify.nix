{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.spotify = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = with pkgs; [
      spotify
      spotify-tray
    ];

    xdg = {
      mimeApps = {
        defaultApplications = lib.mkBefore (
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
}