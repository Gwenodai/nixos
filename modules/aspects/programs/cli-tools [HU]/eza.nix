{ den, ... }:
let
  eza = den.lib.perUser {
    homeManager = {
      # TODO: Configure eza
      programs.eza = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        icons = "always";
        git = true;
        extraOptions = [
          "--group-directories-first"
          "--header"
        ];
      };
    };
  };
in
{
  den.aspects.cli.includes = [
    eza
  ];
}
