# Host system config
{
  den,
  ...
}: {
  # Declare host system and users
  den.hosts.x86_64-linux.gwen-t1.users.gwen = {};
  
  den.aspects.gwen-t1 = {
    includes = with den.aspects; [
      # systemd-boot
      # kernel-cachyos
      # preservation
      # amdcpu
      # amdgpu
      # it87
      # lact
    ];

    nixos = {
      networking.hostName = "gwen-t1";
    };
  };
}