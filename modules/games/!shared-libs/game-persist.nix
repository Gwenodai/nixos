{
  # Generic persistence configs for native linux game save directories
  # intended to be shared by game launchers like Steam. (intended for users)
  den.aspects.game-libs._.game-persist = {
    persistUser = { hmConfig, ... }: {
      directories = [
        { # Unity savegames
          directory = "${hmConfig.xdg.configHome}/unity3d";
          how = "symlink";
          createLinkTarget = true;
        }
        { # Godot savegames
          directory = "${hmConfig.xdg.dataHome}/godot/app_userdata";
          how = "symlink";
          createLinkTarget = true;
        }
      ];
    };

    persistUserTmp = { hmConfig, ... }: {
      ".local" = {};                     # "~/.local"
      "${hmConfig.xdg.dataHome}" = {};   # "~/.local/share"
      "${hmConfig.xdg.configHome}" = {}; # "~/.config"
      "${hmConfig.xdg.dataHome}/godot" = {};
    };
  };
}
