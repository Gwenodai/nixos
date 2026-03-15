{ den, ... }: {
  den.aspects.hardware = {
    _.amdcpu = {
      nixos = { config, lib, ... }: {
        hardware.cpu.amd.updateMicrocode =
          lib.mkDefault config.hardware.enableRedistributableFirmware;

        boot.kernelParams = [ "amd_pstate=active" ];
        powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
      };

      # The performance module automatically enables the amdcpu module
      _.performance = {
        includes = [ den.aspects.hardware._.amdcpu ];
        nixos = {
          boot.kernelParams = [
            "preempt=full"
            "split_lock_detect=off"
          ];
        };
      };
    };
  };
}
