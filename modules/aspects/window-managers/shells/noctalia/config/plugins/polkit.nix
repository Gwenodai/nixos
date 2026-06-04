{
  den.aspects.noctalia = {
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

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/noctalia/plugins/polkit-agent"
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
        # "~/.config/noctalia/plugins"
        "${hmConfig.xdg.configHome}" = { };
        "${hmConfig.xdg.configHome}/noctalia" = { };
        "${hmConfig.xdg.configHome}/noctalia/plugins" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        files = [
          # "~/.config/noctalia/colors.json"
          "${hmConfig.xdg.configHome}/noctalia/colors.json"
        ];
      };
  };
}
