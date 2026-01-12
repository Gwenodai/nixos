{
  flake.modules.homeManager.gwen = { ... }: {
    programs.git = {
      settings = {
        user = {
          name = "Gwenodai";
          email = "gwenpark37@gmail.com";
        };
      };
    };
  };
}