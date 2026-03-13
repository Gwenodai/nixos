{
  den.aspects.shell = {
    # TODO: Configure bash
    # https://mynixos.com/home-manager/options/programs.bash
    provides.bash = {
      homeManager = { lib, ... }: {
        programs.bash = {
          enable = lib.mkDefault true;
          enableCompletion = lib.mkDefault true;
        };
      };
    };
  };
}
