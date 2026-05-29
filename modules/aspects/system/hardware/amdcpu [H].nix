{ den, lib, ... }:
{
  den.aspects.hardware.amdcpu = {
    nixos =
      { config, ... }:
      {
        hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

        boot.kernelParams = [ "amd_pstate=active" ];
        powerManagement.cpuFreqGovernor = "performance";
      };

    lowLatencyScheduler = {
      nixos.boot.kernelParams = [
        "preempt=full"
        "split_lock_detect=off"
      ];
    };
  };

  den.aspects.hardware.autoConfig =
    { host, ... }:
    let
      hw = host.hardware.cpu;
      baseAspect = den.aspects.hardware.amdcpu;
    in
    {
      includes = lib.optionals (hw.vendor == "amd") (
        [ baseAspect ]
        ++ lib.optionals hw.lowLatencyScheduler [
          baseAspect.lowLatencyScheduler
        ]
      );
    };
}
