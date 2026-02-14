{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.amdgpu = {
    ...
  }: {
    hardware.amdgpu = {
      initrd.enable = true; # Load driver early
      overdrive = {
        enable = true;
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/include/amd_shared.h#n187
        ppfeaturemask = "0xfffd7fff"; # Enables all except 'STUTTER_MODE' and 'GFXOFF'
      };
    };

    boot.kernelParams = [
      "gpu_sched.sched_policy=0" # Disables the FIFO GPU scheduling policy 
      "amdgpu.ignore_min_pcap=1" # Allows going below the minimum power cap on AMD GPUs
    ];
  };
}