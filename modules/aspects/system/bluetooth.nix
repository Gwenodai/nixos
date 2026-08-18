{
  den.aspects.bluetooth = {
    nixos = { host, ... }: {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = host.hostConfig.bluetoothPowerOnBoot;
      };
    };

    ### Persist config
    persist = {
      directories = [
        {
          directory = "/var/lib/bluetooth";
          mode = "0700";
        }
      ];
    };
  };

  den.schema.host = { lib, ... }: {
    options.hostConfig.bluetoothPowerOnBoot = lib.mkOption {
      description = "Whether bluetooth should be powered on at boot.";
      type = lib.types.bool;
      default = false;
    };
  };
}
