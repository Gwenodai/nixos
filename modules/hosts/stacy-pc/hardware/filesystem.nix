# Host disko config
{
  den.aspects.stacy-pc = {
    disko = (import ./_disko.nix).disko;
    nixos.fileSystems = {
      "/var/log".neededForBoot = true;
    };
  };
}
