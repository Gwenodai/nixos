{ den, ... }:
{
  den.aspects.environment = {
    niri = {
      # Set the default login session to Niri
      nixos.services.displayManager.defaultSession = "niri";

      includes = with den.aspects; [
        ### Core Aspects
        niri
        noctalia

        ### Theming
        stylix

        ### Applications
        gnome-calendar
      ];
    };
  };
}
