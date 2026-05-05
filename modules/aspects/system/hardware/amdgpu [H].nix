{ den, ... }:
let
  amdgpu = den.lib.perHost {
    nixos = {
      hardware.amdgpu = {
        initrd.enable = true; # Load driver early
      };
    };

    persistUser =
      { hmConfig, ... }:
      {
        directories = [
          "${hmConfig.xdg.cacheHome}/mesa_shader_cache"
          "${hmConfig.xdg.cacheHome}/radv_builtin_shaders"
        ];
      };
  };

  overclock = den.lib.perHost {
    nixos = {
      hardware.amdgpu.overdrive = {
        enable = true;
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/include/amd_shared.h#n187
        ppfeaturemask = "0xfffd7fff"; # Enables all except 'STUTTER_MODE' and 'GFXOFF'
      };
      boot.kernelParams = [
        "amdgpu.ignore_min_pcap=1" # Allows going below the minimum power cap on AMD GPUs
        "gpu_sched.sched_policy=0" # Disables the FIFO GPU scheduling policy
      ];
    };
  };
in
{
  den.aspects.amdgpu.includes = [ amdgpu ];
  den.aspects.amdgpu._.overclock.includes = [ overclock ];
}
