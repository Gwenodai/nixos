# Basic system persistence
{
  flake.modules.nixos.preservation = {
    config,
    lib,
    ...
  }: {
    config = lib.mkIf config.preservation.enable {
      preservation = {
        preserveAt."/persist" = {
          directories = [
            "/var/lib/systemd/coredump"
            "/etc/NetworkManager/system-connections"
            { directory = "/var/lib/nixos"; inInitrd = true; }
          ];
          files = map (x: {
            file = x;
            how = "symlink";
            inInitrd = true;
            configureParent = true;
          }) [
            "/etc/machine-id"
            "/var/lib/systemd/random-seed"
          ];
        };
      };

      # The following section is needed for compatibility with systemd's ConditionFirstBoot:
      # Skips generating standard systemd configuration
      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
      # Define our own service
      systemd.services.systemd-machine-id-commit = {
        # Ensure service will only run if this path is mounted
        unitConfig.ConditionPathIsMountPoint = [
          ""
          "/persist/etc/machine-id"
        ];
        # Ensure service commits the ID to the persistent volume
        serviceConfig.ExecStart = [
          ""
          "systemd-machine-id-setup --commit --root /persist"
        ];
      };
    };
  };
}