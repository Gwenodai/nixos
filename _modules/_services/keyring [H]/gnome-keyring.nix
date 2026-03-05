{
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.keyring = {
    config,
    pkgs,
    lib,
    ...
  }: {
    services.gnome-keyring = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.gnome-keyring;
    };

    xdg.portal.config.common = lib.mkIf config.services.gnome-keyring.enable {
      "org.freedesktop.impl.portal.Secret" = lib.mkDefault [
        "gnome-keyring"
      ];
    };
  };
}