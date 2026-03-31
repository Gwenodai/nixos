{ den, ... }: {
  den.aspects.kde-connect = {
    includes = with den.aspects.kde-connect._; [ valent ];

    _.valent = den.lib.perHost {
      nixos = { pkgs, lib, ... }: {
        programs.kdeconnect = {
          enable = lib.mkDefault true;
          package = lib.mkDefault pkgs.valent;
        };
      };

      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/valent";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
          {
            directory = "${hmConfig.xdg.cacheHome}/valent";
            mode = "0700";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };
      persistUserTmp = { hmConfig, ... }: {
        "${hmConfig.xdg.configHome}" = {}; # "~/.config
        "${hmConfig.xdg.cacheHome}" = {};  # "~/.cache
      };
    };
  };
}
