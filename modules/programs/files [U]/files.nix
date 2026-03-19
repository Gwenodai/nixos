{ den, ... }: {
  den.aspects.files = {
    includes = with den.aspects.files._; [ nemo ];
    
    _.nemo = den.lib.perUser {
      homeManager = { pkgs, lib, ... }: {
        # File browser for Cinnamon
        home.packages = with pkgs; [ nemo ];

        xdg = {
          mimeApps = {
            defaultApplications = lib.mkBefore (
              let
                application = "nemo.desktop";
                mimeTypes = [
                  "inode/directory"
                  "application/x-gnome-saved-search"
                ];
              in lib.genAttrs mimeTypes (mimetype: application)
            );
            associations.added = let
              application = "nemo-autorun-software.desktop";
              mimeTypes = [
                "x-content/unix-software"
              ];
            in lib.genAttrs mimeTypes (mimetype: application);
          };
        };
      };
    };
  };
}
