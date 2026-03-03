{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.nemo = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = with pkgs; [
      nemo # File browser for Cinnamon
    ];

    xdg = {
      mimeApps = {
        defaultApplications = lib.mkBefore (
          let
            application = "nemo.desktop";
            mimeTypes = [
              "inode/directory"
              "application/x-gnome-saved-search"
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application)
        );
        associations.added = let
          application = "nemo-autorun-software.desktop";
          mimeTypes = [
            "x-content/unix-software"
          ];
        in
        lib.genAttrs mimeTypes (mimetype: application);
      };
    };
  };
}