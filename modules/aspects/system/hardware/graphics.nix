{ den, lib, ... }:
{
  den.aspects.hardware.graphics = {
    nixos = {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };

  den.aspects.hardware.autoConfig =
    { host, ... }:
    let
      gpuVendor = host.hardware.gpu.vendor;
      baseAspect = den.aspects.hardware.graphics;
    in
    {
      includes = lib.optionals (gpuVendor != null) [ baseAspect ];
    };
}
