{
  den.aspects.audio = {
    nixos = {
      services = {
        pulseaudio.enable = false;
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          wireplumber.enable = true;
        };
      };
      security.rtkit.enable = true;
    };

    ### Persist config
    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.local/state/wireplumber"
          {
            directory = "${hmConfig.xdg.stateHome}/wireplumber";
            mode = "0700";
          }
        ];
      };

    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.local/state"
        ".local" = { };
        "${hmConfig.xdg.stateHome}" = { };
      };
  };
}
