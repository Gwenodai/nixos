{ inputs, den, ... }:
{
  den.aspects.stacy-pc = {
    #---Filesystem Config---#
    nixos = {
      inherit (import ./_disko.nix) disko;
      fileSystems = {
        "/var/log".neededForBoot = true;
      };
    };

    #---Network Shares---#
    includes = [
      #---Ymir Network Shares---#
      ### Network Storage
      (den.batteries.mount-cifs {
        hostName = "ymir";
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
      ### Webpages
      (den.batteries.mount-cifs {
        hostName = "ymir";
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
      ### Movies & TV Shows
      (den.batteries.mount-cifs {
        hostName = "ymir";
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
