{ den, ... }:
{
  den.aspects.hardware = {
    _.graphics = den.lib.perHost {
      nixos =
        { lib, ... }:
        {
          hardware.graphics = {
            enable = lib.mkDefault true;
            enable32Bit = lib.mkDefault true;
          };
        };
    };

    _.amdgpu = {
      _.enable = den.lib.perHost {
        includes = [ den.aspects.hardware._.graphics ];

        nixos =
          { lib, ... }:
          {
            hardware.amdgpu = {
              initrd.enable = lib.mkDefault true; # Load driver early
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

      _.overclock = den.lib.perHost {
        nixos =
          { lib, ... }:
          {
            hardware.amdgpu.overdrive = {
              enable = lib.mkDefault true;
              # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/include/amd_shared.h#n187
              ppfeaturemask = lib.mkDefault "0xfffd7fff"; # Enables all except 'STUTTER_MODE' and 'GFXOFF'
            };
            boot.kernelParams = [
              "amdgpu.ignore_min_pcap=1" # Allows going below the minimum power cap on AMD GPUs
              "gpu_sched.sched_policy=0" # Disables the FIFO GPU scheduling policy
            ];
          };
      };
    };
  };
}
