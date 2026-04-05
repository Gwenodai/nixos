# REQUIRES GNOME-KEYRING SERVICE
{ den, ... }: {
  den.aspects.calendar = {
    # The default sub-aspect included when the generic 'calendar' aspect is used
    includes = with den.aspects.calendar._; [ gnome-calendar ];
    
    _.gnome-calendar = den.lib.perUser {
      nixos = { lib, ... }: {
        services.gnome = {
          evolution-data-server.enable = lib.mkDefault true;
          gnome-online-accounts.enable = lib.mkDefault true;
        };
      };

      homeManager = { pkgs, lib, ... }: {
        home.packages = with pkgs; [
          gnome-control-center # Needed to log into calendar services
          gnome-calendar
        ];

        xdg.mimeApps.defaultApplications = lib.mkBefore (
          let
            application = "org.gnome.Calendar.desktop";
            mimeTypes = [
              "text/calendar"
            ];
          in lib.genAttrs mimeTypes (mimetype: application)
        );

        # Allow GNOME settings to run outside of GNOME
        xdg.desktopEntries."org.gnome.Settings" = lib.mkDefault {
          name = "Settings";
          icon = "org.gnome.Settings";
          # Make the application think we're running the GNOME desktop
          exec = "env XDG_CURRENT_DESKTOP=GNOME gnome-control-center";
          terminal = false;
          type = "Application";
          categories = [
            "GNOME"
            "GTK"
            "Settings"
          ];
          settings = {
            Keywords = "Preferences;Settings";
            X-Purism-FormFactor = "Workstation;Mobile";
          };
        };

      };

      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.cacheHome}/evolution";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
          {
            directory = "${hmConfig.xdg.configHome}/evolution";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
          {
            directory = "${hmConfig.xdg.configHome}/goa-1.0";
            how = "symlink";
            createLinkTarget = true;
          }
          {
            directory = "${hmConfig.xdg.dataHome}/evolution";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                     # "~/.local"
        "${hmConfig.xdg.dataHome}" = {};   # "~/.local/share"
        "${hmConfig.xdg.cacheHome}" = {};  # "~/.cache"
        "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      };
    };
  };
}
