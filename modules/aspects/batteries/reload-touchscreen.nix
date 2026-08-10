/*
  Rebinds the touchscreen device after the system resumes from sleep
  Fixes touchscreen input reverting to mouse input after sleep

  The systemd service runs after the system resumes from sleep following the `sleep.target` unit. See:
  https://github.com/NixOS/nixpkgs/blob/f13ff45afd1bb73e640eaa08a7066dbed07e3238/nixos/modules/config/power-management.nix
  https://www.freedesktop.org/software/systemd/man/latest/systemd.special.html#sleep.target
*/
{ lib, ... }: {
  den.batteries.reload-touchscreen =
    # This battery takes deviceId as context.
    # It can be found with the following command:
    # \ls -1 /sys/bus/hid/drivers/hid-multitouch/ | \grep -Eo '[0-9a-fA-F]{4}:[0-9a-fA-F]{4}:[0-9a-fA-F]{4}'
    deviceId:
    let
      deviceIdPattern = "^[0-9a-fA-F]{4}:[0-9a-fA-F]{4}:[0-9a-fA-F]{4}$";
      deviceIdMatches = lib.match deviceIdPattern deviceId != null;
      serviceSuffix = lib.replaceStrings [ ":" ] [ "-" ] deviceId;
      serviceName = "reload-touchscreen-resume-${serviceSuffix}";
    in
    assert
      deviceIdMatches || throw "reload-touchscreen deviceId '${deviceId}' must match ${deviceIdPattern}";
    {
      nixos =
        {
          pkgs,
          ...
        }:
        let
          driverDir = "/sys/bus/hid/drivers/hid-multitouch";

          touchscreenReloadScript = pkgs.writeShellApplication {
            name = "reload-touchscreen-hid-${serviceSuffix}";
            runtimeInputs = [
              pkgs.coreutils
            ];
            text = ''
              # syntax: sh
              # Enable null glob to handle empty glob patterns gracefully
              shopt -s nullglob

              matchingDevices=()

              # Attempt to find the device for 10 seconds (20 attempts with 0.5s sleep)
              for attempt in $(seq 1 20); do
                matchingDevices=()
                for touchscreenDevicePath in "${driverDir}/${deviceId}."*; do
                  matchingDevices+=("$touchscreenDevicePath")
                done

                if [ "''${#matchingDevices[@]}" -gt 0 ]; then
                  break
                fi

                echo "waiting for device, attempt $attempt" >&2
                sleep 0.5
              done

              # Exit if no device was found
              if [ "''${#matchingDevices[@]}" -eq 0 ]; then
                echo "Timed out waiting for device matching ${driverDir}/${deviceId}.*" >&2
                exit 1
              fi

              # Verify write permissions on the sysfs control files
              if [ ! -w "${driverDir}/unbind" ] || [ ! -w "${driverDir}/bind" ]; then
                echo "Required sysfs files are not writable: ${driverDir}/unbind or ${driverDir}/bind" >&2
                exit 1
              fi

              # Reload the touchscreen device by unbinding and rebinding it
              for touchscreenDevicePath in "''${matchingDevices[@]}"; do
                device="$(basename "$touchscreenDevicePath")"
                echo "$device" > "${driverDir}/unbind"
                echo "$device" > "${driverDir}/bind"
              done
            '';
          };
        in
        {
          systemd.services.${serviceName} = {
            description = "Rebind HID Multitouch Touchscreen on Resume";
            wantedBy = [ "sleep.target" ];
            unitConfig.StopWhenUnneeded = true;
            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
              ExecStop = "${touchscreenReloadScript}/bin/reload-touchscreen-hid-${serviceSuffix}";
            };
          };
        };
    };
}
