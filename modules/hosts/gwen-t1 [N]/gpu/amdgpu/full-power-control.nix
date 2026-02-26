{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    lib,
    ...
  }: {
    boot.kernelParams = [
      "amdgpu.ignore_min_pcap=1" # Allows going below the minimum power cap on AMD GPUs
    ];
  };
}