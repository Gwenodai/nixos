{
  den.aspects.runelite = {
    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = [ pkgs.bolt-launcher ];
          # Fixes issues with resizing the runelite window (at least on WMs like Niri)
          sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
        };
      };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/bolt-launcher"
          {
            directory = "${hmConfig.xdg.configHome}/bolt-launcher";
            how = "symlink";
            createLinkTarget = true;
          }
          # "~/.local/share/bolt-launcher"
          {
            directory = "${hmConfig.xdg.dataHome}/bolt-launcher";
            how = "symlink";
            createLinkTarget = true;
          }
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
  };
}
