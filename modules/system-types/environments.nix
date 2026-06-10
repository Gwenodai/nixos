{ den, ... }:
{
  den.aspects.environment = {
    niri = {
      # Set the default login session to Niri
      nixos.services.displayManager.defaultSession = "niri";

      includes = with den.aspects; [
        #---Compositor & Desktop Shell---#
        niri
        noctalia

        #---Visual Theming---#
        stylix
      ];
    };
  };
}
