{
  den.aspects.ananicy = {
    nixos =
      { pkgs, ... }:
      {
        services.ananicy = {
          enable = true;
          package = pkgs.ananicy-cpp;
          rulesProvider = pkgs.ananicy-rules-cachyos;
        };
      };
  };
}
