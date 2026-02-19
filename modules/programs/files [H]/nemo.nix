{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.files = {
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
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application)
        );
      };
    };
  };
}