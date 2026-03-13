{
  den.aspects.hardware = {
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
