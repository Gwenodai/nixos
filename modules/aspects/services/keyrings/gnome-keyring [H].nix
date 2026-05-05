{ den, ... }:
{
  den.aspects.gnome-keyring = den.lib.perHost {
    nixos =
      { config, lib, ... }:
      {
        services.gnome.gnome-keyring.enable = true;
        programs.seahorse.enable = true;

        xdg.portal.config.common = lib.mkIf config.services.gnome.gnome-keyring.enable {
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
      };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          {
            directory = "${hmConfig.xdg.dataHome}/keyrings";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
          {
            directory = "${hmConfig.home.homeDirectory}/.gnupg";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
      };
    persistUserTmp =
      { hmConfig, ... }:
      {
        ".local" = { }; # "~/.local"
        "${hmConfig.xdg.dataHome}" = { }; # "~/.local/share"
      };
  };
}
