{
  den.aspects.lact = {
    nixos =
      { lib, ... }:
      {
        services.lact.enable = true;

        # Set up the environment config defaults
        environment.etc."lact/config.yaml" = {
          enable = lib.mkDefault false;
          mode = lib.mkDefault "0644";
          text = lib.mkDefault null;
        };
      };

    ### Persist config
    persist =
      { config, lib, ... }:
      {
        directories = lib.mkIf (!config.environment.etc."lact/config.yaml".enable) [
          {
            directory = "/etc/lact";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

    persistIgnore =
      { config, lib, ... }:
      {
        directories = lib.mkIf config.environment.etc."lact/config.yaml".enable [
          "/etc/lact"
        ];
      };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.config/lact"
          {
            directory = "${hmConfig.xdg.configHome}/lact";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
      };
  };
}
