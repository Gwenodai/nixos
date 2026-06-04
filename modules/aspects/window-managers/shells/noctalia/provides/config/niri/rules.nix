{ den, ... }:
let
  rules = {
    niri.settings = {
      layer-rules = [
        {
          # Render walpaper in backdrop for overview mode
          matches = [ { namespace = "^noctalia-overview*"; } ];
          place-within-backdrop = true;
        }
      ];
    };
  };
in
{
  den.aspects.noctalia._.config.includes = [
    rules
  ];
}
