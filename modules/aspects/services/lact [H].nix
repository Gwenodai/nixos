{ den, lib, ... }:
let
  lact = den.lib.perHost {
    nixos = {
      services.lact.enable = true;
    };

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
        "${hmConfig.xdg.configHome}" = { }; # "~/.config
      };
  };

  class = den.lib.perHost (
    { host }:
    { class, aspect-chain }:
    den._.forward {
      each = lib.singleton true;
      fromClass = _: "lact";
      intoClass = _: host.class;
      intoPath = _: [
        "environment"
        "etc"
        "lact/config.yaml"
      ];
      fromAspect = _: lib.head aspect-chain;
      guard = { config, ... }: _item: lib.mkIf (config.services.lact.enable);
    }
  );

  # Sets up the environment configs for the class to use
  setup = {
    nixos =
      { config, lib, ... }:
      {
        environment.etc."lact/config.yaml" = {
          enable = lib.mkDefault (config.environment.etc."lact/config.yaml".text != null);
          mode = lib.mkDefault "0644";
          text = lib.mkDefault null;
        };
      };
  };
in
{
  den.aspects.lact = {
    # All sub-aspects are included when the generic 'lact' aspect is used
    includes = [
      lact
      setup
      class
    ];
  };
}
