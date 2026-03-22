{ den, ... }: {
  # General linux game directories that should be persisted
  den.aspects.steam._.game-persist = den.lib.perUser {
    persistUser = { hmConfig, ... }: {
      directories = [
        "${hmConfig.xdg.configHome}/unity3d"
      ];
    };

    persistUserTmp = { hmConfig, ... }: {
      "${hmConfig.xdg.configHome}" = {}; # "~/.config"
    };
  };
}
