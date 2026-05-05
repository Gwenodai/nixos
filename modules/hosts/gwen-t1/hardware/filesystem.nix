# Host disko config
{
  den.aspects.gwen-t1 = {
    nixos = {
      # Import raw disko config
      disko = (import ./_disko.nix).disko;
      fileSystems = {
        "/persist".neededForBoot = true;
        "/var/log".neededForBoot = true;
      };
    };
  };
}
