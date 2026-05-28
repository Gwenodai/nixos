let
  amdcpu = {
    nixos =
      { config, ... }:
      {
        hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

        boot.kernelParams = [ "amd_pstate=active" ];
        powerManagement.cpuFreqGovernor = "performance";
      };
  };

  performance = {
    nixos.boot.kernelParams = [
      "preempt=full"
      "split_lock_detect=off"
    ];
  };

in
{
  den.aspects.hardware.amdcpu = {
    includes = [ amdcpu ];
    performance.includes = [ performance ];
  };
}
