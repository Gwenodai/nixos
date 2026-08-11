{
  den.aspects.networking = {
    nixos = {
      networking.networkmanager.enable = true;
    };

    ### Persist config
    persist = {
      directories = [
        "/var/lib/NetworkManager"
      ];
    };
  };
}
