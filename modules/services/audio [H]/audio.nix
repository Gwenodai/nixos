{ den, ... }:
{
  den.aspects.audio = {
    includes = with den.aspects.audio._; [ pipewire ];

    _.pipewire = den.lib.perHost {
      nixos =
        { lib, ... }:
        {
          services = {
            pulseaudio.enable = lib.mkDefault false;
            pipewire = {
              enable = lib.mkDefault true;
              alsa.enable = lib.mkDefault true;
              alsa.support32Bit = lib.mkDefault true;
              pulse.enable = lib.mkDefault true;
              wireplumber.enable = lib.mkDefault true;
            };
          };
          security.rtkit.enable = lib.mkDefault true;
        };

      persistUser =
        { hmConfig, ... }:
        {
          directories = [
            {
              directory = "${hmConfig.xdg.stateHome}/wireplumber";
              mode = "0700";
            }
          ];
        };

      persistUserTmp =
        { hmConfig, ... }:
        {
          ".local" = { }; # "~/.local"
          "${hmConfig.xdg.stateHome}" = { }; # "~/.local/state"
        };
    };
  };
}
