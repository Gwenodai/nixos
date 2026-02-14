{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.amdcpu = {
    config,
    ...
  }: {
    hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

    boot.kernelParams = [
      "amd_pstate=active"
    ];
  };
}