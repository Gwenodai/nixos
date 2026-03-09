# Host disko config
{
  ...
}: {
  den.aspects.gwen-t1 = let
    # Import raw disko config
    diskoConfig = import ./_disko.nix;
  in {
    disko = diskoConfig; # Add it to the disko class
    nixos.fileSystems = {
      "/persist".neededForBoot = true;
      "/var/log".neededForBoot = true;
    };
  };
}