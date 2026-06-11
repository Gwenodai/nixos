{ inputs, den, ... }:
{
  den.aspects.gwen-t1 = {
    #---Filesystem Config---#
    nixos = {
      disko = (import ./_disko.nix).disko;
      fileSystems = {
        "/persist".neededForBoot = true;
        "/var/log".neededForBoot = true;
      };
    };

    #---Network Shares---#
    includes = [
      #---Ymir Network Shares---#
      ### Root Directory
      (den.batteries.mount-cifs {
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
      ### Network Storage
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
      ### Movies & TV Shows
      (den.batteries.mount-cifs {
        host = inputs.self.lib.hosts.ymir.ip;
        resource = "Media";
        destination = "/mnt/ymir/media";
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
