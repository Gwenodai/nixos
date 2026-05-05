{ den, ... }:
let
  amdcpu = den.lib.perHost {
    nixos =
      { config, ... }:
      {
        hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

        boot.kernelParams = [ "amd_pstate=active" ];
        powerManagement.cpuFreqGovernor = "performance";
      };
  };

  performance = den.lib.perHost {
    nixos.boot.kernelParams = [
      "preempt=full"
      "split_lock_detect=off"
    ];
  };
in
{
  den.aspects.amdcpu.includes = [ amdcpu ];
  den.aspects.amdcpu._.performance.includes = [ performance ];
}
