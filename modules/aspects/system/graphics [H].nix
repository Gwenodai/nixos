{ den, ... }:
let
  graphics = {
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
