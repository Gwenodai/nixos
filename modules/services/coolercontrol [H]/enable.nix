{ den, ... }: {
  den.aspects.coolercontrol._.enable = den.lib.perHost {
    nixos = { config, pkgs, lib, ... }: {
      programs.coolercontrol.enable = lib.mkDefault true;
        
      environment.systemPackages = with pkgs; [
        lm_sensors # Tools for reading hardware sensors
        liquidctl  # Drivers for AIO liquid coolers and other devices
      ];
    };

    persistIgnore.directories = [ "/etc/coolercontrol" ];
  };
}
