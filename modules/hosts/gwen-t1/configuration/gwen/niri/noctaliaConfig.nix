{
  den.aspects.gwen-t1.noctalia = {
    settings = builtins.fromJSON (builtins.readFile ./_noctaliaConfig.json);
  };
}
