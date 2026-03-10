# Host disko config
{
  ...
}: {
  den.aspects.gwen-t1 = {
    disko = (import ./_disko.nix).disko; # Import raw disko config
    nixos.fileSystems = {
      "/persist".neededForBoot = true;
      "/var/log".neededForBoot = true;
    };
  };
}