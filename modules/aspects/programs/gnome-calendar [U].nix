# REQUIRES GNOME-KEYRING SERVICE
{ den, ... }:
{
  den.aspects.gnome-calendar = den.lib.perUser {
    nixos = {
      services.gnome = {
        evolution-data-server.enable = true;
        gnome-online-accounts.enable = true;
      };
    };

    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [
          gnome-control-center # Needed to log into calendar services
          gnome-calendar
        ];

        xdg.mimeApps.defaultApplications = (
          let
            application = "org.gnome.Calendar.desktop";
            mimeTypes = [
              "text/calendar"
            ];
          in
          lib.genAttrs mimeTypes (mimetype: application)
        );

        # Allow GNOME settings to run outside of GNOME
        xdg.desktopEntries."org.gnome.Settings" = {
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

    persistUser =
      { hmConfig, ... }:
      {
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

    persistUserTmp =
      { hmConfig, ... }:
      {
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
        "${hmConfig.xdg.cacheHome}" = { }; # "~/.cache"
        "${hmConfig.xdg.configHome}" = { }; # "~/.config"
      };
  };
}
