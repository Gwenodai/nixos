{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.amdcpu = {
    config,
    lib,
    ...
  }: {
    hardware.cpu.amd.updateMicrocode = lib.mkDefault
      config.hardware.enableRedistributableFirmware;

    boot.kernelParams = [
      "amd_pstate=active"
    ];
  };
}