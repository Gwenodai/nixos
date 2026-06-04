{
  den.aspects.cli-tools = {
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
          # "~/.local/share/direnv/allow"
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
        # "~/.local/share/direnv"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
        "${hmConfig.xdg.dataHome}/direnv" = { };
      };
  };
}
