# Host system config
{ self, den, ... }: {
  den.aspects.gwen-t1 = {
    includes = [
      den.aspects.persist
      den.aspects.boot.provides.systemd
      den.aspects.kernel.provides.cachyos
      den.aspects.kernel.provides.modules.provides.it87
      den.aspects.hardware.provides.amdcpu
      den.aspects.hardware.provides.graphics.provides.amdgpu
    ];
    
    nixos = { lib, ... }: {
      sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";
    };
  };
}