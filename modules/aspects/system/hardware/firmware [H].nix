{ den, ... }:
{
  den.aspects.firmware = den.lib.perHost {
    nixos = {
      services.fwupd.enable = true;
      hardware = {
        enableAllFirmware = true;
        enableRedistributableFirmware = true;
      };
    };

    persist.directories = [
      {
        directory = "/var/lib/fwupd";
        user = "fwupd-refresh";
        group = "fwupd-refresh";
      }
    ];
  };
}
