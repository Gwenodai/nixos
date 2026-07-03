{
  den.aspects.noctalia = {
    niri.settings = {
      layer-rules = [
        ## Render walpaper in backdrop for overview mode
        {
          matches = [ { namespace = "^noctalia-backdrop"; } ];
          place-within-backdrop = true;
        }
      ];
    };
  };
}
