{
  den.aspects.noctalia = {
    homeManager =
      { config, ... }:
      {
        home.file = {
          "${config.xdg.configHome}/noctalia/colorschemes/Rosey AMOLED/Rosey AMOLED.json" = {
            force = true;
            source = ./. + "/_Rosey AMOLED.json";
          };
        };
      };
  };
}
