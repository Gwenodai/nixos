{ den, ... }: {
  den.aspects.gwen-t1 = {
    includes = [
      (den.aspects.mount-cifs {
        host = "192.168.1.64"; # TODO: Use predefined server cifs config
        resource = "Network-Storage";
        destination = "/mnt/ymir/root";
        UID = 1000;
        GID = 1000;
        extraOptions = [
          "guest"
          "noperm"
          "nounix"
          "nobrl"
        ];
      })
    ];
  };
}