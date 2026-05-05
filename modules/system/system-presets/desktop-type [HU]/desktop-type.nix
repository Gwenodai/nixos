# Preset desktop types.
# These should be imported by BOTH hosts and users wanting to use them.
{ den, ... }:
{
  den.aspects.desktop-type = {
    _.desktop-environment = { }; # None defined yet

    _.window-manager = {
      _.niri = {
        includes = with den.aspects; [
          (den.lib.perHost {
            # Set the default login session to Niri
            nixos.services.displayManager.defaultSession = "niri";
          })
          # ---Core Aspects--- #
          niri
          noctalia # Minimal desktop shell
          stylix # Theming

          # ---Basic Desktop Applications--- #
          calendar
        ];
      };
    };
  };
}
