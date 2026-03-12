{ den, ... }: {
  den.aspects.audio = {
    includes = with den.aspects.audio.provides; [
      audio
      persist
    ];

    provides.audio = {
      nixos = { lib, ... }: {
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
    };
    
    provides.persist = {
      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.stateHome}/wireplumber";
            mode = "0700";
          }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        ".local" = { };                    # "~/.local"
        "${hmConfig.xdg.stateHome}" = { }; # "~/.local/state"
      };
    };
  };
}
