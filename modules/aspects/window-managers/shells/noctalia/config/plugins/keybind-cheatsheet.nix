{
  den.aspects.noctalia = {
    homeManager = {
      programs.noctalia-shell = {
        plugins = {
          states.keybind-cheatsheet = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };

        pluginSettings = {
          keybind-cheatsheet = {
            columnCount = 2;
          };
        };
      };
    };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/noctalia/plugins/keybind-cheatsheet"
          {
            directory = "${hmConfig.xdg.configHome}/noctalia/plugins/keybind-cheatsheet";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.config/noctalia/plugins"
        "${hmConfig.xdg.configHome}" = { };
        "${hmConfig.xdg.configHome}/noctalia" = { };
        "${hmConfig.xdg.configHome}/noctalia/plugins" = { };
      };
  };
}
