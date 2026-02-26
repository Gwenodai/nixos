# Host filesystem config
{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    ...
  }: {
    imports =[
      ./_disko.nix # Filesystem is configured through disko
    ];

    fileSystems = {
      "/persist".neededForBoot = true;
      "/var/log".neededForBoot = true;
    };
  };
}
