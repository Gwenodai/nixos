{
  den.aspects.gnome-keyring = {
    nixos =
      { config, lib, ... }:
      {
        services.gnome.gnome-keyring.enable = true;
        programs.seahorse.enable = true;

        xdg.portal.config.common = lib.mkIf config.services.gnome.gnome-keyring.enable {
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
      };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.local/share/keyrings"
          {
            directory = "${hmConfig.xdg.dataHome}/keyrings";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
          # "~/.gnupg"
          # {
          #   directory = "${hmConfig.home.homeDirectory}/.gnupg";
          #   how = "symlink";
          #   mode = "0700";
          #   createLinkTarget = true;
          # }
        ];
      };
    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.local/share"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
      };
  };
}
