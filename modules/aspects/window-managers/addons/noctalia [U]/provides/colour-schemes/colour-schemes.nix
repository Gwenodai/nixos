{ den, ... }:
{
  den.aspects.noctalia._.colour-schemes = den.lib.perUser {
    homeManager =
      { config, ... }:
      {
        home.file = {
          "${config.xdg.configHome}/noctalia/colorschemes/Rosey AMOLED/Rosey AMOLED.json" = {
            source = ./. + "/_Rosey AMOLED.json";
            force = true;
          };
        };
      };
  };
}
