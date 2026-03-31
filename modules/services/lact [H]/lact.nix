{ den, lib, ... }: {
  den.aspects.lact = {
    # All sub-aspects are included when the generic 'lact' aspect is used
    includes = lib.attrValues den.aspects.lact._;

    _.enable = den.lib.perHost {
      nixos = { lib, ... }: {
        services.lact.enable = lib.mkDefault true;
      };

      persist = { config, lib, ... }: {
        directories = lib.mkIf (!config.environment.etc."lact/config.yaml".enable) [
          {
            directory = "/etc/lact";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

      persistIgnore = { config, lib, ... }: {
        directories = lib.mkIf config.environment.etc."lact/config.yaml".enable [
          "/etc/lact"
        ];
      };

      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/lact";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        "${hmConfig.xdg.configHome}" = {}; # "~/.config
      };
    };

    _.class = { 
       # Bundles all class components when the complete 'class' sub-aspect is used
      includes = with den.aspects.lact._.class._; [
        enable
        setup
      ];

      _.enable = den.lib.perHost (
        { host }: { class, aspect-chain }: den._.forward {
          each = lib.singleton true;
          fromClass = _: "lact";
          intoClass = _: host.class;
          intoPath = _: [ "environment" "etc" "lact/config.yaml" ];
          fromAspect = _: lib.head aspect-chain;
          guard = { config, ... }: _item: lib.mkIf (config.services.lact.enable);
        }
      );

      # Sets up the environment configs for the class to use
      _.setup = {
        nixos = { config, lib, ... }: {
          environment.etc."lact/config.yaml" = {
            enable = lib.mkDefault (config.environment.etc."lact/config.yaml".text != null);
            mode = lib.mkDefault "0644";
            text = lib.mkDefault null;
          };
        };
      };
    };
  };
}
