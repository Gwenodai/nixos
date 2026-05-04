{ den, ... }:
{
  den.aspects.coolercontrol._.enable = den.lib.perHost {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        programs.coolercontrol.enable = lib.mkDefault true;

        environment.systemPackages = with pkgs; [
          lm_sensors # Tools for reading hardware sensors
          liquidctl # Drivers for AIO liquid coolers and other devices
        ];
      };

    persist.directories = [
      {
        directory = "/etc/coolercontrol";
        how = "symlink";
        createLinkTarget = true;
      }
    ];

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          "${hmConfig.xdg.dataHome}/org.coolercontrol.CoolerControl"
          "${hmConfig.xdg.cacheHome}/org.coolercontrol.CoolerControl"
          "${hmConfig.xdg.configHome}/org.coolercontrol.CoolerControl"
        ];
      };
  };
}
