{
  den.aspects.firmware = {
    nixos = {
      services.fwupd.enable = true;
      hardware = {
        enableAllFirmware = true;
        enableRedistributableFirmware = true;
      };
    };

    ### Persist config
    persist = {
      directories = [
        {
          directory = "/var/lib/fwupd";
          user = "fwupd-refresh";
          group = "fwupd-refresh";
        }
      ];
    };
  };
}
