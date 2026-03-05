{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.amdgpu = {
    lib,
    ...
  }: {
    hardware.amdgpu = {
      initrd.enable = lib.mkDefault true; # Load driver early
      overdrive = {
        enable = lib.mkDefault true;
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/include/amd_shared.h#n187
        ppfeaturemask = lib.mkDefault "0xfffd7fff"; # Enables all except 'STUTTER_MODE' and 'GFXOFF'
      };
    };

    boot.kernelParams = [
      "gpu_sched.sched_policy=0" # Disables the FIFO GPU scheduling policy
    ];
  };
}