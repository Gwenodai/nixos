# Preset desktop types.
# These should be imported by BOTH hosts and users wanting to use them.
{ __findFile, den, ... }:
{
  den.aspects.wm-preset-niri = {
    includes = with den.aspects; [
      # Set the default login session to Niri
      { nixos.services.displayManager.defaultSession = "niri"; }
      # ---Core Aspects--- #
      <niri>
      <niri/config>
      <noctalia> # Minimal desktop shell
      <noctalia/config>
      <noctalia/colour-schemes>
      stylix # Theming

      # ---Basic Desktop Applications--- #
      gnome-calendar
    ];
  };
}
