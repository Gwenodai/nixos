{ den, lib, ... }: {
  den.aspects.lact = {
    includes = with den.aspects.lact._; [ enable ];

    _.enable = {
      nixos.services.lact.enable = true;
      persistIgnore.directories = [ "/etc/lact" ];
    };

    # Include in a host to enable configuring lact with nix
    _.manualConfig = den.lib.take.exactly ({ host }: den._.forward {
      each = lib.singleton true;
      fromClass = _: "lact";
      intoClass = _: host.class;
      intoPath = _: [ "environment" "etc" "lact/config.yaml" ];
      fromAspect = _: den.aspects.${host.aspect};
    });
  };
}
