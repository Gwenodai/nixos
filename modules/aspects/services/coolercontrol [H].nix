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
in
{
  den.aspects.coolercontrol.includes = [
    coolerControl

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
