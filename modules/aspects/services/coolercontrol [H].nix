{ den, lib, ... }:
let
  coolerControl = den.lib.perHost {
    nixos =
      {
        config,
        pkgs,
        ...
      }:
      {
        programs.coolercontrol.enable = true;

        environment.systemPackages = with pkgs; [
          lm_sensors # Tools for reading hardware sensors
          liquidctl # Drivers for AIO liquid coolers and other devices
        ];
      };

    persist.directories = [
      {
        directory = "/etc/coolercontrol";
        how = "symlink";
        createLinkTarget = true;
      }
    ];

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          "${hmConfig.xdg.dataHome}/org.coolercontrol.CoolerControl"
          "${hmConfig.xdg.cacheHome}/org.coolercontrol.CoolerControl"
          "${hmConfig.xdg.configHome}/org.coolercontrol.CoolerControl"
        ];
      };
  };

  # Factory to generate cooler-control classes
  mkClass =
    { fromClass, intoSubPath }:
    den.lib.perHost (
      { host }:
      { class, aspect-chain }:
      den._.forward ({
        each = lib.singleton true;
        fromClass = _: fromClass;
        intoClass = _: host.class;
        intoPath = _: [
          "environment"
          "etc"
          "coolercontrol/${intoSubPath}"
        ];
        fromAspect = _: lib.head aspect-chain;
      })
    );

  setup = den.lib.perHost {
    nixos =
      { config, lib, ... }:
      {
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
  };
in
{
  den.aspects.coolercontrol.includes = [
    coolerControl
    setup

    (mkClass {
      fromClass = "coolercontrol-config";
      intoSubPath = "config.toml";
    })
    (mkClass {
      fromClass = "coolercontrol-alerts";
      intoSubPath = "alerts.json";
    })
    (mkClass {
      fromClass = "coolercontrol-ui";
      intoSubPath = "config-ui.json";
    })
  ];
}
