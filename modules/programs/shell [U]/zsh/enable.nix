{ den, ... }:
{
  den.aspects.shell._.zsh._.enable = den.lib.perUser {
    homeManager =
      { config, lib, ... }:
      {
        programs.zsh = {
          enable = lib.mkDefault true;
          dotDir = lib.mkDefault "${config.xdg.configHome}/zsh";
        };
      };

    persistUser =
      { hmConfig, ... }:
      {
        files = [
          {
            file = "${hmConfig.xdg.configHome}/zsh/.zsh_history";
            mode = "0600";
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        "${hmConfig.xdg.configHome}" = { }; # "~/.config"
        "${hmConfig.xdg.configHome}/zsh" = { };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        files = [ "${hmConfig.xdg.configHome}/zsh/.zcompdump" ];
      };
  };
}
