{ den, ... }: {
  den.aspects.hardware = {
    provides.graphics = {
      nixos = { lib, ... }: {
        hardware.graphics = {
          enable = lib.mkDefault true;
          enable32Bit = lib.mkDefault true;
        };
      };
      
      # The amdgpu module automatically enables the graphics module
      provides.amdgpu = {
        includes = with den.aspects.hardware.provides; [
          graphics
          graphics.provides.amdgpu.provides.persist
        ];
        nixos = { lib, ... }: {
          hardware.amdgpu = {
            initrd.enable = lib.mkDefault true; # Load driver early
            overdrive = {
              enable = lib.mkDefault true;
              # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/include/amd_shared.h#n187
              ppfeaturemask = lib.mkDefault "0xfffd7fff"; # Enables all except 'STUTTER_MODE' and 'GFXOFF'
            };
          };
          # Disables the FIFO GPU scheduling policy
          boot.kernelParams = [ "gpu_sched.sched_policy=0" ];
        };
        # ---Persist config--- #
        provides.persist = {
          persistUser = { hmConfig, ... }: {
            directories = [
              "${hmConfig.xdg.cacheHome}/mesa_shader_cache"
              "${hmConfig.xdg.cacheHome}/radv_builtin_shaders"
            ];
          };
        };
      };
    };

    provides.amdcpu = {
      nixos = { config, lib, ... }: {
        hardware.cpu.amd.updateMicrocode =
          lib.mkDefault config.hardware.enableRedistributableFirmware;

        boot.kernelParams = [ "amd_pstate=active" ];
        powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
      };
    };
  };
}
