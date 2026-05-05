{ den, ... }:
{
  den.aspects.noctalia._.niri._.rules = den.lib.perUser {
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
}
