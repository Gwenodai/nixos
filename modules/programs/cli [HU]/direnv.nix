{ den, ... }:
{
  den.aspects.cli._.direnv = den.lib.perUser {
    homeManager =
      { lib, ... }:
      {
        programs.direnv = {
          enable = lib.mkDefault true;
          nix-direnv.enable = lib.mkDefault true;
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
        ".local" = { }; # "~/.local"
        "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
        "${hmConfig.xdg.dataHome}/direnv" = { };
      };
  };
}
