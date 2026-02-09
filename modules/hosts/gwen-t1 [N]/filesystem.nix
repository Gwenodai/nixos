# Host filesystem config
{ ... }: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = { ... }: {
    disko.devices = {
      disk = {
        Samsung-990-PRO-4TB = {
          device = "/dev/disk/by-id/nvme-eui.0025384a41bd2579";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              # Boot
              ESP = {
                name = "ESP";
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              # Persistent storage
              NIXOS = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L NIXOS"
                    "-f"
                  ];
                  subvolumes = {
                    "nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                        "ssd"
                      ];
                    };
                    "log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                        "ssd"
                      ];
                    };
                    "persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                        "ssd"
                      ];
                    };
                    "home" = {
                      mountpoint = "/persist/home";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                        "ssd"
                      ];
                    };
                    "swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "64G";
                    };
                  };
                };
              };
            };
          };
        };
      };
      # Ephemeral root
      nodev."/" = {
        fsType = "tmpfs";
        mountOptions = [
          "mode=755"
          "size=50%"
          "noatime"
        ];
      };
    };

    fileSystems."/persist".neededForBoot = true;
    fileSystems."/var/log".neededForBoot = true;
  };
}
