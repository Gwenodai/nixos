{ den, ... }:
{
  den.aspects.umu-launcher = {
    includes = with den.aspects.umu-launcher._; [ enable ];

    _.enable = den.lib.perUser {
      homeManager =
        { pkgs, lib, ... }:
        {
          home.packages = with pkgs; [ umu-launcher ];
        };

      persistUser =
        { hmConfig, ... }:
        {
          directories = [
            "${hmConfig.xdg.dataHome}/umu"
          ];
        };

      persistUserTmp =
        { hmConfig, ... }:
        {
          ".local" = { }; # "~/.local"
          "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
        };

      persistUserIgnore =
        { hmConfig, ... }:
        {
          directories = [ "${hmConfig.xdg.cacheHome}/winetricks" ];
          files = [ "${hmConfig.xdg.cacheHome}/umu-protonfixes/protonfixes_test.log" ];
        };
    };
  };
}
