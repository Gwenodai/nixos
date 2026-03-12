# Minimal necessary preservation configuration
{
  den.aspects.persist = {
    provides.minimalNix = {
      # ---System--- #
      persist = { home, ... }: {
        directories = [
          "/var/lib/systemd/coredump"
          "/var/lib/systemd/timers"
          "/etc/NetworkManager/system-connections"
          { directory = "/var/lib/nixos"; inInitrd = true; }
        ];
        files = [
          {
            file = "/etc/machine-id";
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

      # Common NixOS directories we don't want to parse with `find-ephemeral`
      persistIgnore.directories = [
        "/boot"
        "/nix"
        "/proc"
        "/run"
        "/sys"
        "/tmp"
        "/var/log"
      ];

      nixos = { pkgs, lib, ... }: {
        # Required compatibility with systemd's ConditionFirstBoot for `/etc/machine-id`
        systemd.services.systemd-machine-id-commit = lib.mkDefault {
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
    };
    
    provides.minimalHome = { user, ... }: {
      # ---User--- #
      persistUser = { hmConfig, lib, ... }: {
        # Prevent preservation mounts from appearing as such in graphical file managers
        commonMountOptions = lib.mkDefault [ "x-gvfs-hide" ];

        directories = [
          "${hmConfig.xdg.dataHome}/systemd/timers"
          { directory = ".pki"; mode = "0700"; }
          "dots" # Nix flake directory
        ];
      };

      # Create intermediate directories via `systemd.tmpfiles`
      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                   # "~/.local"
        "${hmConfig.xdg.dataHome}" = {}; # "~/.local/share"
      };

      # Common user directories we don't want to parse with `find-ephemeral`
      persistUserIgnore = { hmConfig, ... }: {
        directories = [
          "${hmConfig.xdg.cacheHome}/nix"                # "~/.cache/nix"
          "${hmConfig.xdg.stateHome}/nix"                # "~/.local/state/nix"
          "${hmConfig.xdg.stateHome}/nix-output-monitor" # "~/.local/state/nix-output-monitor"
        ];
      };
    };
  };
}