{ den, ... }: {
  den.aspects.keyring = {
    includes = with den.aspects.keyring._; [ gnome-keyring ];

    _.gnome-keyring = den.lib.perUser {
      homeManager = { config, lib, ... }: {
        services.gnome-keyring.enable = lib.mkDefault true;

        xdg.portal.config.common = lib.mkIf config.services.gnome-keyring.enable {
          "org.freedesktop.impl.portal.Secret" = lib.mkDefault [ "gnome-keyring" ];
        };
      };

      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.dataHome}/keyrings";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
      };
      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                   # "~/.local"
        "${hmConfig.xdg.dataHome}" = {}; # "~/.local/share"
      };
    };
  };
}
