# Host disko config
{
  den.aspects.stacy-pc = {
    disko = (import ./_disko.nix); # Import raw disko config
    nixos.fileSystems = {
      "/var/log".neededForBoot = true;
    };
  };
}