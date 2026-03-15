{
  den.aspects.hardware = {
    _.firmware = {
      nixos = { lib, ... }: {
        services.fwupd.enable = lib.mkDefault true;
        hardware = {
          enableAllFirmware = lib.mkDefault true;
          enableRedistributableFirmware = lib.mkDefault true;
        };
      };
    };
  };
}
