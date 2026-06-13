{ den, lib, ... }:
{
  den.aspects.hardware = {
    amdgpu = {
      nixos = {
        hardware.amdgpu = {
          initrd.enable = true; # Load driver early
        };
      };

      ### Persist config
      persistUser =
        { hmConfig, ... }:
        {
          directories = [
            # "~/.cache/mesa_shader_cache"
            "${hmConfig.xdg.cacheHome}/mesa_shader_cache"
            # "~/.cache/radv_builtin_shaders"
            "${hmConfig.xdg.cacheHome}/radv_builtin_shaders"
          ];
        };

      persistUserTmp =
        { hmConfig, ... }:
        {
          # "~/.cache"
          "${hmConfig.xdg.cacheHome}" = { };
        };
    };

    amdgpu.advancedPowerManagement = {
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
  };

  den.aspects.hardware.autoConfig =
    { host, ... }:
    let
      hw = host.hardware.gpu;
      baseAspect = den.aspects.hardware.amdgpu;
    in
    {
      includes = lib.optionals (hw.vendor == "amd") (
        [ baseAspect ]
        ++ lib.optionals hw.advancedPowerManagement [
          baseAspect.advancedPowerManagement
        ]
      );
    };
}
