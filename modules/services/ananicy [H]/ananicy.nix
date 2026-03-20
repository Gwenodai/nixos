{ den, ... }: {
  den.aspects.ananicy = {
    includes = with den.aspects.ananicy._; [ enable ];

    _.enable = den.lib.perHost {
      nixos = { pkgs, lib, ... }: {
        services.ananicy = {
          enable = lib.mkDefault true;
          package = lib.mkDefault pkgs.ananicy-cpp;
        };
      };
    };
  };
}
