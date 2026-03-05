# Disable secondary monitor during boot and re-enable it after login
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    config,
    pkgs,
    lib,
    ...
  }: let
    wakeup-script = pkgs.writeShellScriptBin "wakeup-secondary-display" ''
      echo on > /sys/kernel/debug/dri/1/HDMI-A-1/force
      echo 1 > /sys/kernel/debug/dri/1/HDMI-A-1/trigger_hotplug
    '';
    script-command = "${wakeup-script}/bin/wakeup-secondary-display";
  in {
    config = lib.mkMerge [
      {
        environment.systemPackages = [ wakeup-script ];
        boot.kernelParams = [ "video=HDMI-A-1:d" ]; # Disable secondary screen at boot
        security.sudo.extraRules = [
          {
            users = [ "gwen" ];
            commands = [ 
              { # Allow 'gwen' to run this specific script with sudo and no password
                command = script-command;
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ];
      }
      (
        lib.mkIf (config.programs.niri.enable or false) { # Niri enable code
          # --- HOME MANAGER MODULE ---
          home-manager.users.gwen = {
            ...
          }: {
            programs.niri.settings.spawn-at-startup = [
              # Enable secondary monitor after login
              { sh = "sudo ${script-command}"; }
            ];
          };
        }
      )
    ];
  };
}