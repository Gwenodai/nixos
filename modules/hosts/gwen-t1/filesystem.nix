# Host disko config
{
  den,
  ...
}: {
  den.aspects.gwen-t1 = let
    diskoConfig = import ./_disko.nix;
  in {
    disko = diskoConfig;
    nixos = {
      fileSystems = {
        "/persist".neededForBoot = true;
        "/var/log".neededForBoot = true;
      };
    };
  };
}