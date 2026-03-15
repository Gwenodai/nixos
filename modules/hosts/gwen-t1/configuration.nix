# Host system config
{ self, den, ... }: {
  den.aspects.gwen-t1 = {
    includes = with den.aspects; [
      persist
      boot._.systemd
      kernel._.cachyos
      kernel._.modules._.it87
      hardware._.amdcpu._.performance
      hardware._.graphics._.amdgpu._.overclock
      system-type._.desktop._.gaming
    ];
    
    nixos = { lib, ... }: {
      sops.defaultSopsFile = self + "/secrets/gwen/secrets.yaml";
    };
  };
}