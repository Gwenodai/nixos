{ den, lib, ... }: {
  den.aspects.lact = {
    includes = with den.aspects.lact._; [ enable class ];

    _.enable = den.lib.perHost {
      nixos = { config, lib, ... }: {
        services.lact.enable = true;
        
        environment.etc."lact/config.yaml" = {
          enable = lib.mkDefault (config.environment.etc."lact/config.yaml".text != null);
          mode = lib.mkDefault "0644";
          text = lib.mkDefault null;
        };
      };

      persistIgnore.directories = [ "/etc/lact" ];
    };

    _.class = den.lib.perHost ({ host }: den._.forward {
      each = lib.singleton true;
      fromClass = _: "lact";
      intoClass = _: host.class;
      intoPath = _: [ "environment" "etc" "lact/config.yaml" ];
      fromAspect = _: den.aspects.${host.aspect};
    });
  };
}
