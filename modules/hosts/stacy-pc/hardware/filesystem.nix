# Host disko config
{
  den.aspects.stacy-pc = {
    nixos = {
      # Import raw disko config
      disko = (import ./_disko.nix).disko;
      fileSystems = {
        "/var/log".neededForBoot = true;
      };
    };
  };
}
