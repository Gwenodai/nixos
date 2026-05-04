{ den, ... }:
{
  den.aspects.keyring = {
    includes = with den.aspects.keyring._; [ gnome-keyring ];

    _.gnome-keyring = den.lib.perHost {
      nixos =
        { config, lib, ... }:
        {
          services.gnome.gnome-keyring.enable = lib.mkDefault true;
          programs.seahorse.enable = lib.mkDefault true;

          xdg.portal.config.common = lib.mkIf config.services.gnome.gnome-keyring.enable {
            "org.freedesktop.impl.portal.Secret" = lib.mkDefault [ "gnome-keyring" ];
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
  };
}
