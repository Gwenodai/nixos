{ __findFile, den, ... }:
{
  den.aspects.environment = {
    niri = {
      # Set the default login session to Niri
      nixos.services.displayManager.defaultSession = "niri";

      includes = with den.aspects; [
        ### Core Aspects
        niri
        <noctalia> # Minimal desktop shell
        <noctalia/config>
        <noctalia/colour-schemes>
        stylix # Theming

        ### Basic Desktop Applications
        gnome-calendar
      ];
    };
  };
}
