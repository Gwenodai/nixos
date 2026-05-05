{ den, ... }:
let
  graphics = den.lib.perHost {
    nixos = {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
in
{
  den.aspects.graphics.includes = [ graphics ];
}
