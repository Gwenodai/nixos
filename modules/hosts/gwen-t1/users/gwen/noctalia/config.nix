{
  den.aspects.gwen-t1.noctalia = { lib, ... }: {
    settings = lib.fromJSON (lib.readFile ./_settings.json);
  };
}
