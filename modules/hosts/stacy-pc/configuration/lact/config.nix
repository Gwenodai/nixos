{ lib, ... }:
{
  den.aspects.stacy-pc = {
    nixos = {
      environment.etc."lact/config.yaml".text = lib.readFile ./_config.yaml;
    };
  };
}
