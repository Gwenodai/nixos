{ inputs, den, ... }:
{
  den.aspects.noctalia._.plugins._.polkit = den.lib.perUser {
    homeManager =
      { lib, ... }:
      {
        programs.noctalia-shell = {
          plugins = inputs.self.lib.applyDefaults {
            states.polkit-agent = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
          };
        };

        services.polkit-gnome.enable = lib.mkOverride 900 false;
      };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/noctalia/plugins/polkit-agent";
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

    persistUserIgnore =
      { hmConfig, ... }:
      {
        files = [
          "${hmConfig.xdg.configHome}/noctalia/colors.json"
        ];
      };
  };
}
