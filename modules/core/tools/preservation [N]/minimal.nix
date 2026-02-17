# Minimal necessary preservation configuration
{
  # --- NIXOS MODULE ---
  flake.modules.nixos.preservation = {
    pkgs,
    ...
  }: {
    preservation = {
      preserveAt."/persist" = {
        directories = [
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
          { directory = "/var/lib/nixos"; inInitrd = true; }
        ];
        files = [
          {
            file = "/etc/machine-id";
            how = "bindmount";
            inInitrd = true;
            configureParent = true;
          }
          {
            file = "/var/lib/systemd/random-seed";
            how = "symlink";
            inInitrd = true;
            configureParent = true;
          }
        ];
      };
      ignore = {
        directories = [
          "/boot"
          "/nix"
          "/proc"
          "/run"
          "/sys"
          "/tmp"
          "/var/log"
        ];
      };
    };

    # Required compatibility with systemd's ConditionFirstBoot for `/etc/machine-id`
    systemd.services.systemd-machine-id-commit = {
      # Ensure service will only run if the persistent storage is mounted
      unitConfig.ConditionPathIsMountPoint = [
        ""
        "/persist"
      ];
      # Ensure service commits the ID to the persistent volume
      serviceConfig.ExecStart = [
        ""
        "${pkgs.systemd}/bin/systemd-machine-id-setup --commit --root /persist"
      ];
    };
  };

  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.preservation = {
    config,
    ...
  }: {
    preservation = {
      preserveAt."/persist" = {
        directories = [
          { # Nix flake directory
            directory = "dots";
            how = "bindmount";
          }
          { # Nix flake directory
            directory = ".pki";
            how = "bindmount";
            mode = "0700";
          }
        ];
        commonMountOptions = [
          "x-gvfs-hide" # Prevent Preservation mounts from appearing as such in graphical file managers
        ];
      };

      ignore = {
        directories = [
          "${config.xdg.cacheHome}/nix"
          "${config.xdg.stateHome}/nix"
          "${config.xdg.stateHome}/nix-output-monitor"
        ];
      };
    };
  };
}
