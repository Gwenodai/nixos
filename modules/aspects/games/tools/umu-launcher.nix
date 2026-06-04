{
  den.aspects.umu-launcher = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.umu-launcher ];
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
}
