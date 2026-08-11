{
  den.aspects.bluetooth = {
    nixos = {
      hardware.bluetooth.enable = true;
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
}
