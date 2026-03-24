# Minimal necessary preservation configuration
{ den, ... }: {
  den.aspects.persist._.minimal = {
    includes = with den.aspects.persist._.minimal._; [ sys user ];

    _.sys = den.lib.perHost {
      persist = {
        directories = [
          "/var/lib/systemd/timers"
          "/var/lib/systemd/rfkill"
          "/var/lib/systemd/coredump"
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
          {
            file = "/var/lib/dhcpcd/duid";
            user = "dhcpcd";
            group = "dhcpcd";
            configureParent = true;
            parent = {
              user = "dhcpcd";
              group = "dhcpcd";
            };
          }
          {
            file = "/var/lib/systemd/timesync/clock";
            mode = "0644";
            user = "systemd-timesync";
            group = "systemd-timesync";
            configureParent = true;
            parent = {
              user = "systemd-timesync";
              group = "systemd-timesync";
            };
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

    _.user = den.lib.perHost {
      persistUser = { hmConfig, lib, ... }: {
        # Prevent preservation mounts from appearing as such in graphical file managers
        commonMountOptions = lib.mkDefault [ "x-gvfs-hide" ];

        directories = [
          "dots" # Nix flake directory
          { directory = ".pki"; mode = "0700"; }
          "${hmConfig.xdg.dataHome}/systemd/timers"
          "${hmConfig.xdg.cacheHome}/gtk-4.0/vulkan-pipeline-cache"
          "${hmConfig.xdg.cacheHome}/qtshadercache-x86_64-little_endian-lp64"
        ];
        files = [
          { file = "${hmConfig.xdg.configHome}/dconf/user"; mode = "0644"; }
        ];
      };

      # Create intermediate directories via `systemd.tmpfiles`
      persistUserTmp = { hmConfig, ... }: {
        ".local" = {};                     # "~/.local"
        "${hmConfig.xdg.dataHome}" = {};   # "~/.local/share"
        "${hmConfig.xdg.configHome}" = {}; # "~/.config"
        "${hmConfig.xdg.cacheHome}/gtk-4.0" = {};
      };

      # Common user directories we don't want to parse with `find-ephemeral`
      persistUserIgnore = { hmConfig, ... }: {
        directories = [
          "${hmConfig.xdg.cacheHome}/nix"
          "${hmConfig.xdg.cacheHome}/typescript"
          "${hmConfig.xdg.cacheHome}/X11/xcompose"
          "${hmConfig.xdg.cacheHome}/thumbnails"
          "${hmConfig.xdg.stateHome}/nix"
          "${hmConfig.xdg.stateHome}/nix-output-monitor"
        ];
        files = [
          ".pulse-cookie"
          "${hmConfig.xdg.configHome}/pulse/cookie"
          "${hmConfig.xdg.dataHome}/nix/repl-history"
          "${hmConfig.xdg.configHome}/glow/glow.yml"
          "${hmConfig.xdg.cacheHome}/glow/glow.log"
          "${hmConfig.xdg.cacheHome}/gstreamer-1.0/registry.x86_64.bin"
        ];
      };
    };
  };
}