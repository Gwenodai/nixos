{
  den.aspects.preservation = {
    ### Persist config
    nixos = {
      ### Required compatibility with systemd's ConditionFirstBoot for `/etc/machine-id`
      boot.initrd.systemd.tmpfiles.settings.preservation."/sysroot/persistent/etc/machine-id".f = {
        argument = "uninitialized";
      };

      # Let the service commit the transient ID to the persistent volume
      systemd.services.systemd-machine-id-commit = {
        unitConfig.ConditionPathIsMountPoint = [
          ""
          "/persist"
        ];
        serviceConfig.ExecStart = [
          ""
          "systemd-machine-id-setup --commit --root /persist"
        ];
      };
    };

    ## Host Preservation Config
    persist = {
      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/systemd/rfkill"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
          how = "symlink";
          configureParent = true;
          createLinkTarget = true;
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
    persistIgnore = {
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

    ## User Preservation Config
    persistUser =
      { hmConfig, ... }:
      {
        # Prevent preservation mounts from appearing as such in graphical file managers
        commonMountOptions = [ "x-gvfs-hide" ];

        directories = [
          # "~/dots"
          "dots" # Nix flake directory
          # "~/.pki"
          {
            directory = ".pki";
            mode = "0700";
          }
          # "~/.config/dconf"
          "${hmConfig.xdg.configHome}/dconf"
          # "~/.local/share/systemd/timers"
          "${hmConfig.xdg.dataHome}/systemd/timers"
          # "~/.cache/gtk-4.0/vulkan-pipeline-cache"
          "${hmConfig.xdg.cacheHome}/gtk-4.0/vulkan-pipeline-cache"
          # "~/.cache/qtshadercache-x86_64-little_endian-lp64"
          "${hmConfig.xdg.cacheHome}/qtshadercache-x86_64-little_endian-lp64"
        ];
      };

    # Create intermediate directories via `systemd.tmpfiles`
    persistUserTmp =
      { hmConfig, ... }:
      {
        # "~/.local/share"
        ".local" = { };
        "${hmConfig.xdg.dataHome}" = { };
        # "~/.config"
        "${hmConfig.xdg.configHome}" = { };
        # "~/.cache"
        "${hmConfig.xdg.cacheHome}" = { };
        # "~/.cache/gtk-4.0"
        "${hmConfig.xdg.cacheHome}/gtk-4.0" = { };
      };

    # Common user directories we don't want to parse with `find-ephemeral`
    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/nix"
          "${hmConfig.xdg.cacheHome}/nix"
          # "~/.cache/typescript"
          "${hmConfig.xdg.cacheHome}/typescript"
          # "~/.cache/X11/xcompose"
          "${hmConfig.xdg.cacheHome}/X11/xcompose"
          # "~/.cache/thumbnails"
          "${hmConfig.xdg.cacheHome}/thumbnails"
          # "~/.local/state/nix"
          "${hmConfig.xdg.stateHome}/nix"
          # "~/.local/state/nix-output-monitor"
          "${hmConfig.xdg.stateHome}/nix-output-monitor"
        ];
        files = [
          # "~/.pulse-cookie"
          ".pulse-cookie"
          # "~/.config/pulse/cookie"
          "${hmConfig.xdg.configHome}/pulse/cookie"
          # "~/.local/share/nix/repl-history"
          "${hmConfig.xdg.dataHome}/nix/repl-history"
          # "~/.cache/gstreamer-1.0/registry.x86_64.bin"
          "${hmConfig.xdg.cacheHome}/gstreamer-1.0/registry.x86_64.bin"
          # "~/.config/glow/glow.yml"
          "${hmConfig.xdg.configHome}/glow/glow.yml"
          # "~/.cache/glow/glow.log"
          "${hmConfig.xdg.cacheHome}/glow/glow.log"
        ];
      };
  };
}
