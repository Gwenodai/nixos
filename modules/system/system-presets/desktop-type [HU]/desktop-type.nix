# Preset desktop types.
# These should be imported by BOTH hosts and users wanting to use them.
{ den, ... }: {
  den.aspects.desktop-type = {
    _.desktop-environment = {};

    _.window-manager = {
      _.niri = {
        includes = with den.aspects; [
          # ---Core Aspects--- #
          niri
          noctalia # Minimal desktop shell
          stylix   # Theming
        ];
      };
    };
  };
}
