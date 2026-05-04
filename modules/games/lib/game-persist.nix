{
  # Generic persistence configs for native linux game save directories
  # intended to be shared by game launchers like Steam. (intended for users)
  den.aspects.lib._.games._.savegame-persist = {
    persistUser =
      { hmConfig, lib, ... }:
      {
        directories =
          lib.map
            (path: {
              directory = path;
              how = "symlink";
              createLinkTarget = true;
            })
            [
              "${hmConfig.xdg.configHome}/unity3d" # Unity savegames
              "${hmConfig.xdg.dataHome}/godot/app_userdata" # Godot savegames
            ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        ".local" = { }; # "~/.local"
        "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
        "${hmConfig.xdg.configHome}" = { }; # "~/.config"
        "${hmConfig.xdg.dataHome}/godot" = { };
      };
  };
}
