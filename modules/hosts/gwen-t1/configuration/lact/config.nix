{ lib, ... }:
{
  den.aspects.gwen-t1 = {
    nixos = {
      environment.etc."lact/config.yaml".text = lib.readFile ./_config.yaml;
    };
  };
}
