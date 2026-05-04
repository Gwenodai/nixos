{ inputs, den, ... }:
{
  den.aspects.gwen-t1 = {
    includes = [
      (den.aspects.mount-cifs {
        host = inputs.self.lib.hosts.ymir.ip;
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
