{ den, ... }:
let
  pipewire = {
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
        ".local" = { };
        "${hmConfig.xdg.stateHome}" = { }; # "~/.local/state"
      };
  };
in
{
  den.aspects.audio.includes = [
    pipewire
  ];
}
