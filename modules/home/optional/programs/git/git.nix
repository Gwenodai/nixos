{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Gwenodai";
        email = "gwenpark37@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}