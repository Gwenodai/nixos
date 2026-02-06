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
  flake.modules.homeManager.preservation = { ... }: {
    home.preservation = {
      preserveAt."/persist" = {
        directories = [
          { # Nix flake directory
            directory = "dots";
            how = "symlink";
            createLinkTarget = true;
          }
        ];
        commonMountOptions = [
          "x-gvfs-hide" # Prevent Preservation mounts from appearing as such in graphical file managers
        ];
      };
    };
  };
}
