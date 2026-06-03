{ den, ... }:
let
  direnv = {
    homeManager = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          {
            directory = "${hmConfig.xdg.dataHome}/direnv/allow";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
        "${hmConfig.xdg.dataHome}/direnv" = { };
      };
  };
in
{
  den.aspects.cli.includes = [
    direnv
  ];
}
