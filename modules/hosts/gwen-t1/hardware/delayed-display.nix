# Writing the exact same script twice is gross, but idk how to use pkgs
# within `let ... in` at the aspect level with den like you can in flake-parts
{
  den.aspects.gwen-t1 = {
    nixos = { pkgs, host, ... }: let
      wakeup-script = pkgs.writeShellScriptBin "wakeup-secondary-display" ''
        echo on > /sys/kernel/debug/dri/1/HDMI-A-1/force
        echo 1 > /sys/kernel/debug/dri/1/HDMI-A-1/trigger_hotplug
      '';
      script-command = "${wakeup-script}/bin/wakeup-secondary-display";
    in {
      environment.systemPackages = [ wakeup-script ];
      boot.kernelParams = [ "video=HDMI-A-1:d" ]; # Disable secondary screen at boot
      security.sudo.extraRules = [
        {
          users = [ "%wheel" ];
          commands = [
            { # Allow 'wheel' group to run this specific script with sudo and no password
              command = script-command;
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };

    # Niri activation logic
    niri = { pkgs, ... }: let
      wakeup-script = pkgs.writeShellScriptBin "wakeup-secondary-display" ''
        echo on > /sys/kernel/debug/dri/1/HDMI-A-1/force
        echo 1 > /sys/kernel/debug/dri/1/HDMI-A-1/trigger_hotplug
      '';
      script-command = "${wakeup-script}/bin/wakeup-secondary-display";
    in {
      # Enable secondary monitor after niri login
      settings.spawn-at-startup = [ { sh = "sudo ${script-command}"; } ];
    };
  };
}