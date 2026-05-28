{ den, ... }:
{
  den.aspects.hardware =
    { lib, ... }:
    let
      makeHardwareAspect =
        key:
        (
          { host, ... }:
          let
            hw = host.${key} or null;
            baseAspect = den.aspects.hardware."${hw.brand}${key}";
          in
          lib.optionalAttrs (host ? ${key} && hw != null) {
            includes = [
              baseAspect
            ]
            ++ lib.optionals (hw.performance or false) [
              baseAspect.performance
            ];
          }
        );
    in
    {
      includes = [
        (makeHardwareAspect "gpu")
        (makeHardwareAspect "cpu")
      ];
    };

  den.schema.host.includes = [ den.aspects.hardware ];
}
