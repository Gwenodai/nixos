# Nemo file browser
{ den, ... }:
{
  den.aspects.nemo = {
    meta = {
      category = "file-manager";
      binPath = "nemo"; # Use predefined nemo override pkg
    };

    ### Nemo required host services
    nixos = {
      services = {
        # GNOME Virtual File System is required for a lot of nemo's functionality
        # like the trash bin, mounting network shares, etc.
        gvfs.enable = true;
        # D-Bus service that allows nemo to query and manipulate storage devices
        udisks2.enable = true;
        # D-Bus thumbnailer service (provides thumbnail generation to nemo)
        tumbler.enable = true;
      };
    };

    homeManager =
      {
        host,
        user,
        pkgs,
        lib,
        ...
      }:
      {
        systemd.user.targets."test".Unit.Documentation =
          let
            activeAspectsList = lib.filter (aspect: user.hasAspect aspect) (lib.attrValues den.aspects);
            # Only list the aspect name itself, not the full attribute set
            activeAspectNames = lib.map (aspect: aspect.name) activeAspectsList;
          in
          activeAspectNames;

        ### Nemo package config
        home.packages = with pkgs; [
          (nemo-with-extensions.override {
            # Disable the default extensions so we can explicity declare them ourself
            useDefaultExtensions = false;
            extensions = [
              nemo-python # Dependency of `nemo-emblems`
              nemo-emblems # Enables folder/file emblem change tab
              nemo-preview # Quick previewer for Nemo
              nemo-fileroller # Archive management within Nemo
              nemo-seahorse # GNOME encryption keys management
            ];
          })
        ];

        ### Nemo settings
        dconf.settings = {
          "org/nemo/preferences" = {
            show-hidden-files = true;
            date-format = "iso";
            quick-renames-with-pause-in-between = true;
            thumbnail-limit = 10485760;
          };

          "org/nemo/preferences/menu-config" = {
            selection-menu-make-link = true;
          };

          "org/nemo/plugins" = {
            disabled-actions = [
              "set-as-background.nemo_action"
              "change-background.nemo_action"
              "add-desklets.nemo_action"
              "90_new-launcher.nemo_action"
              "set-resolution.nemo_action"
            ];
          };

          "org/gtk/settings/file-chooser" = {
            show-hidden = true;
          };

          "org/cinnamon/desktop/applications/terminal" = {
            exec = den.aspects.${lib.head user.activeAspectsByCategory.terminal}.meta.binPath pkgs;
          };
        };

        xdg.mimeApps = {
          defaultApplications = (
            let
              application = "nemo.desktop";
              mimeTypes = [
                "inode/directory"
                "application/x-gnome-saved-search"
              ];
            in
            lib.genAttrs mimeTypes (mimetype: application)
          );
          associations.added =
            let
              application = "nemo-autorun-software.desktop";
              mimeTypes = [
                "x-content/unix-software"
              ];
            in
            lib.genAttrs mimeTypes (mimetype: application);
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, lib, ... }:
      {
        directories = [
          # "~/.local/share/gvfs-metadata"
          {
            directory = "${hmConfig.xdg.dataHome}/gvfs-metadata";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
        ]
        ++
          lib.map
            (path: {
              directory = path;
              how = "symlink";
              createLinkTarget = true;
            })
            [
              # "~/.config/gtk-3.0"
              "${hmConfig.xdg.configHome}/gtk-3.0"
              # "~/.config/nemo"
              "${hmConfig.xdg.configHome}/nemo"
              # "~/.local/share/nemo"
              "${hmConfig.xdg.dataHome}/nemo"
            ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.local/share"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.local/share/Trash"
          "${hmConfig.xdg.dataHome}/Trash"
        ];
        files = [
          # "~/.cache/dconf/user"
          "${hmConfig.xdg.cacheHome}/dconf/user"
        ];
      };
  };
}
