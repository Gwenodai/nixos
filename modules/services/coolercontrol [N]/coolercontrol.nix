{ den, lib, ... }: {
  den.aspects.coolercontrol = {
    includes = with den.aspects.coolercontrol._; [
      enable
      classes
    ];

    _.enable = {
      nixos = { config, pkgs, lib, ... }: {
        programs.coolercontrol = {
          enable = lib.mkDefault true;
        };

        environment.etc = lib.genAttrs [
          "coolercontrol/config.toml"
          "coolercontrol/alerts.json"
          "coolercontrol/config-ui.json"
        ] (file: {
          enable = lib.mkDefault (config.environment.etc.${file}.text != null);
          mode = lib.mkDefault "0644";
          text = lib.mkDefault null;
        });
          
        environment.systemPackages = with pkgs; [
          lm_sensors # Tools for reading hardware sensors
          liquidctl  # Drivers for AIO liquid coolers and other devices
        ];
      };

      persistIgnore.directories = [ "/etc/coolercontrol" ];
    };
    
    _.classes = {
      includes = with den.aspects.coolercontrol._.classes._; [
        config
        alerts
        ui
      ];

      # Individual coolercontrol settings files
      _.config = den.lib.take.exactly ({ host }: den._.forward {
        each = lib.singleton true;
        fromClass = _: "coolercontrol-config";
        intoClass = _: host.class;
        intoPath = _: [ "environment" "etc" "coolercontrol/config.toml" ];
        fromAspect = _: den.aspects.${host.aspect};
      });

      _.alerts = den.lib.take.exactly ({ host }: den._.forward {
        each = lib.singleton true;
        fromClass = _: "coolercontrol-alerts";
        intoClass = _: host.class;
        intoPath = _: [ "environment" "etc" "coolercontrol/alerts.json" ];
        fromAspect = _: den.aspects.${host.aspect};
      });
      
      _.ui = den.lib.take.exactly ({ host }: den._.forward {
        each = lib.singleton true;
        fromClass = _: "coolercontrol-ui";
        intoClass = _: host.class;
        intoPath = _: [ "environment" "etc" "coolercontrol/config-ui.json" ];
        fromAspect = _: den.aspects.${host.aspect};
      });
    };
  };
}
