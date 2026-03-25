{ den, ... }: {
  # Default config for nemo
  den.aspects.files._.nemo._.config = den.lib.perUser {
    homeManager = { pkgs, lib, ... }: {
      dconf.settings = {
        "org/nemo/preferences" = {
          show-hidden-files = lib.mkDefault true;
          date-format = lib.mkDefault "iso";
          quick-renames-with-pause-in-between = lib.mkDefault true;
          thumbnail-limit = lib.mkDefault 10485760;
        };
      
        "org/nemo/preferences/menu-config" = {
          selection-menu-make-link = lib.mkDefault true;
        };

        "org/nemo/plugins" = {
          disabled-actions = lib.mkDefault [
            "set-as-background.nemo_action"
            "change-background.nemo_action"
            "add-desklets.nemo_action"
            "90_new-launcher.nemo_action"
            "set-resolution.nemo_action"
          ];
        };

        "org.gtk.Settings.FileChooser" = {
          show-hidden = lib.mkDefault true;
        };

        "org/cinnamon/desktop/applications/terminal" = {
          # Default terminal is set to kitty (change this if using another terminal)
          exec = lib.mkDefault "${lib.getExe pkgs.kitty}";
        };
      };
    };
  };
}
