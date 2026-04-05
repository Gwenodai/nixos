{ den, ... }: {
  # Nemo file browser
  den.aspects.files._.nemo._.enable = den.lib.perUser {
    nixos = { lib, ... }: {
      services = {
        # GNOME Virtual File System is required for a lot of nemo's functionality
        # like the trash bin, mounting network shares, etc.
        gvfs.enable = lib.mkDefault true;
        # D-Bus service that allows nemo to query and manipulate storage devices
        udisks2.enable = lib.mkDefault true;
        # D-Bus thumbnailer service (provides thumbnail generation to nemo)
        tumbler.enable = lib.mkDefault true;
      };
    };

    homeManager = { pkgs, lib, ... }: {
      # File browser for Cinnamon
      home.packages = with pkgs; [
        (nemo-with-extensions.override {
          # Disable the default extensions so we can explicity declare them ourself
          useDefaultExtensions = false;
          extensions = [
            nemo-python     # Dependency of `nemo-emblems`
            nemo-emblems    # Enables folder/file emblem change tab
            nemo-preview    # Quick previewer for Nemo
            nemo-fileroller # Archive management within Nemo
            nemo-seahorse   # GNOME encryption keys management
          ];
        })
      ];

      # MIME type config
      xdg.mimeApps = {
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

    persistUser = { hmConfig, lib, ... }: {
      directories = [
        {
          directory = "${hmConfig.xdg.dataHome}/gvfs-metadata";
          mode = "0700";
          how = "symlink";
          createLinkTarget = true;
        }
      ] ++ lib.map (path: {
        directory = path;
        how = "symlink";
        createLinkTarget = true;
      }) [
        "${hmConfig.xdg.configHome}/gtk-3.0"
        "${hmConfig.xdg.configHome}/nemo"
        "${hmConfig.xdg.dataHome}/nemo"
      ];
    };

    persistUserTmp = { hmConfig, ... }: {
      ".local" = {};                     # "~/.local"
      "${hmConfig.xdg.dataHome}" = {};   # "~/.local/share"
      "${hmConfig.xdg.configHome}" = {}; # "~/.config"
    };

    persistUserIgnore = { hmConfig, ... }: {
      directories = [
        "${hmConfig.xdg.dataHome}/Trash"
      ];
      files = [
        "${hmConfig.xdg.cacheHome}/dconf/user"
      ];
    };
  };
}
