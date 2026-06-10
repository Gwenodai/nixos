{ inputs, den, ... }:
{
  den.aspects.stacy-pc = {
    includes = [
      # Network storage mount
      (den.batteries.mount-cifs {
        host = inputs.self.lib.hosts.ymir.ip;
        resource = "Storage";
        destination = "/mnt/ymir/storage";
        UID = 1000;
        GID = 1000;
        extraOptions = [
          "guest"
          "noperm"
          "nounix"
          "nobrl"
        ];
      })

      # Webpages mount
      (den.batteries.mount-cifs {
        host = inputs.self.lib.hosts.ymir.ip;
        resource = "www";
        destination = "/mnt/ymir/www";
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
