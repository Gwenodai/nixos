{ den, ... }:
{
  # TODO: Configure bash
  # https://mynixos.com/home-manager/options/programs.bash
  den.aspects.bash = den.lib.perUser {
    homeManager = {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    };
  };
}
