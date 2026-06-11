{
  den.aspects.coolercontrol = {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        programs.coolercontrol.enable = true;

        environment.systemPackages = with pkgs; [
          lm_sensors # Tools for reading hardware sensors
          liquidctl # Drivers for AIO liquid coolers and other devices
        ];

        # Set up environment config defaults
        environment.etc =
          lib.genAttrs
            [
              "coolercontrol/config.toml"
              "coolercontrol/alerts.json"
              "coolercontrol/config-ui.json"
            ]
            (file: {
              enable = lib.mkDefault (config.environment.etc.${file}.text != null);
              mode = lib.mkDefault "0644";
              text = lib.mkDefault null;
            });
      };

    ### Persist config
    persist = {
      directories = [
        {
          directory = "/etc/coolercontrol";
          how = "symlink";
          createLinkTarget = true;
        }
      ];
    };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.local/share/org.coolercontrol.CoolerControl"
          "${hmConfig.xdg.dataHome}/org.coolercontrol.CoolerControl"
          # "~/.cache/org.coolercontrol.CoolerControl"
          "${hmConfig.xdg.cacheHome}/org.coolercontrol.CoolerControl"
          # "~/.config/org.coolercontrol.CoolerControl"
          "${hmConfig.xdg.configHome}/org.coolercontrol.CoolerControl"
        ];
      };
  };
}
