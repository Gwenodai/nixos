{
  den.aspects.noctalia._.colour-schemes = {
    homeManager = { config, lib, ... }: {
      home.file = {
        "${config.xdg.configHome}/noctalia/colorschemes/Rosey AMOLED/Rosey AMOLED.json" = {
          source = ./. + "/_Rosey AMOLED.json";
          force = true;
        };
      };
    };
  };
}