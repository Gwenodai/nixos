{ den, ... }:
let
  keybind-cheatsheet = den.lib.perUser {
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
in
{
  den.aspects.noctalia._.config.includes = [
    keybind-cheatsheet
  ];
}
