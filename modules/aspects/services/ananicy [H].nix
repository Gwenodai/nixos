{ den, ... }:
{
  den.aspects.ananicy = den.lib.perHost {
    nixos =
      { pkgs, ... }:
      {
        services.ananicy = {
          enable = true;
          package = pkgs.ananicy-cpp;
        };
      };
  };
}
