{ den, ... }:
{
  den.aspects.ananicy = {
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
