{
  den.aspects.cli = {
    provides.btop = {
      homeManager = {
        # TODO: Configure btop
        # https://mynixos.com/home-manager/options/programs.btop
        programs.btop.enable = true;
      };
    };
  };
}
