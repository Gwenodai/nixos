{ den, lib, ... }:
let
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
        guard = { config, ... }: _item: lib.mkIf (config.programs.coolercontrol.enable);
      })
    );
in
{
  den.aspects.coolercontrol._.class = {
    # Bundles all class components when the complete 'class' sub-aspect is used
    includes = with den.aspects.coolercontrol._.class._; [
      enable
      setup
    ];

    # Create the classes
    _.enable = {
      includes = [
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
    };

    # Sets up the environment configs for the classes to use
    _.setup = den.lib.perHost {
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
  };
}
