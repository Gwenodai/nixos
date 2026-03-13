{ den, ... }: {
  den.aspects.cli = {
    includes = with den.aspects.cli.provides; [
      bat
      direnv
      eza
      nh
      nixos-pkgs
    ];
  };
}