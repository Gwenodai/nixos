let
  mkWakeupScript =
    pkgs:
    pkgs.writeShellScriptBin "wakeup-secondary-display" ''
      echo on > /sys/kernel/debug/dri/1/HDMI-A-1/force
      echo 1 > /sys/kernel/debug/dri/1/HDMI-A-1/trigger_hotplug
    '';
in
{
  den.aspects.gwen-t1 = {
    nixos =
      { pkgs, host, ... }:
      let
        wakeup-script = mkWakeupScript pkgs;
      in
      {
        environment.systemPackages = [ wakeup-script ];
        boot.kernelParams = [ "video=HDMI-A-1:d" ]; # Disable secondary screen at boot
        security.sudo.extraRules = [
          {
            users = [ "%wheel" ];
            commands = [
              {
                # Allow 'wheel' group to run this specific script with sudo and no password
                command = "${wakeup-script}/bin/wakeup-secondary-display";
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ];
      };

    # Niri activation logic
    niri =
      { pkgs, ... }:
      let
        wakeup-script = mkWakeupScript pkgs;
      in
      {
        # Enable secondary monitor after niri login
        settings.spawn-at-startup = [
          { sh = "sudo ${wakeup-script}/bin/wakeup-secondary-display"; }
        ];
      };
  };
}
