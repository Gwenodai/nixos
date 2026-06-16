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
        boot = {
          #---Boot Config---#
          initrd.availableKernelModules = [
            "nvme"
            "ahci"
            "usbhid"
            "xhci_pci"
            "usb_storage"
            "thunderbolt"
          ];
          # Kernel-based Virtual Machine support
          kernelModules = [ "kvm-amd" ];

          #---Disable Secondary Display Activation---#
          kernelParams = [ "video=HDMI-A-1:d" ];
        };
        environment.systemPackages = [ wakeup-script ];
        security.sudo.extraRules = [
          {
            users = [ "%wheel" ];
            commands = [
              {
                command = "${wakeup-script}/bin/wakeup-secondary-display";
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ];
      };

    #---Display Activation Post Login---#
    ### Niri
    niri =
      { pkgs, ... }:
      let
        wakeup-script = mkWakeupScript pkgs;
      in
      {
        settings.spawn-at-startup = [
          { sh = "sudo ${wakeup-script}/bin/wakeup-secondary-display"; }
        ];
      };
  };
}
