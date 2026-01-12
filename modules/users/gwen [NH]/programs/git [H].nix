{
  flake.modules.homeManager."gwen" = { ... }: {
    programs.git = {
      userName = "Gwenodai";
      userEmail = "gwenpark37@gmail.com";
    };
  };
}
