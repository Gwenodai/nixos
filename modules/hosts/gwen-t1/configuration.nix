# Host system config
{ self, den, ... }: {
  den.aspects.gwen-t1 = {
    includes = with den.aspects; [
      persist
      boot.provides.systemd
      kernel.provides.cachyos
      kernel.provides.modules.provides.it87
      hardware.provides.amdcpu
      hardware.provides.graphics.provides.amdgpu
      hardware.provides.graphics.provides.amdgpu.provides.powercap
      system-type.provides.desktop
    ];
    
    nixos = { lib, ... }: {
      # sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";
    };
  };
}