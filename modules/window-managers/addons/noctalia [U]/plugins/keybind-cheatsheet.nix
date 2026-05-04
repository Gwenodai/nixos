{ inputs, den, ... }:
{
  den.aspects.noctalia._.plugins._.keybind-cheatsheet = den.lib.perUser {
    homeManager =
      { lib, ... }:
      {
        programs.noctalia-shell = {
          plugins = inputs.self.lib.applyDefaults {
            states.keybind-cheatsheet = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
          };

          pluginSettings = inputs.self.lib.applyDefaults {
            keybind-cheatsheet = {
              columnCount = 2;
            };
          };
        };
      };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
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
        "${hmConfig.xdg.configHome}" = { }; # "~/.config"
        "${hmConfig.xdg.configHome}/noctalia" = { };
        "${hmConfig.xdg.configHome}/noctalia/plugins" = { };
      };
  };
}
