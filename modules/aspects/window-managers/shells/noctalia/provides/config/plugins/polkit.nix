{ den, ... }:
let
  polkit = {
    homeManager =
      { lib, ... }:
      {
        programs.noctalia-shell = {
          plugins = {
            states.polkit-agent = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
          };
        };

        services.polkit-gnome.enable = lib.mkForce false;
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
in
{
  den.aspects.noctalia._.config.includes = [
    polkit
  ];
}
