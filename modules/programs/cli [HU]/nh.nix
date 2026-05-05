{ den, ... }:
{
  den.aspects.cli._.nh = {
    # Bundles all nh components when the complete 'nh' sub-aspect is used
    includes = with den.aspects.cli._.nh._; [
      enable
      config
    ];

    _.enable = den.lib.perUser {
      homeManager =
        { lib, ... }:
        {
          programs.nh = {
            enable = lib.mkDefault true;
            clean = {
              enable = lib.mkDefault true;
              extraArgs = lib.mkDefault "--keep-since 30d --keep 3";
            };
          };
        };
    };

    _.config = den.lib.perUser {
      homeManager =
        { config, lib, ... }:
        {
          programs.nh = {
            flake = lib.mkDefault "${config.home.homeDirectory}/dots";
            osFlake = lib.mkDefault "${config.home.homeDirectory}/dots";
            homeFlake = lib.mkDefault "${config.home.homeDirectory}/dots";
          };
        };
    };
  };
}
