# Host system config
{
  inputs,
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    imports = with inputs.self.modules.nixos; [
      systemd-boot
      kernel-cachyos
      system-desktop
      preservation
      amdcpu
      amdgpu
      it87 # Custom it87 driver for MB sensors
      lact
    ];

    # TODO: Make a proper networking module
    networking.useDHCP = true;
    networking.hostName = "gwen-t1";

    powerManagement.cpuFreqGovernor = "performance";
  };
}