{ den, ... }:
{
  den.aspects.cli._.btop = den.lib.perUser {
    homeManager = {
      # TODO: Configure btop
      # https://mynixos.com/home-manager/options/programs.btop
      programs.btop.enable = true;
    };
  };
}
