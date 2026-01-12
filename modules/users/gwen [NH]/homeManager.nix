{
  inputs,
  ...
}: let
  username = "gwen";

  flake.modules.homeManager."${username}" = {
    pkgs,
    ...
  }: {
    imports = with inputs.self.modules.homeManager; [
      system-desktop
    ];
    home.username = "${username}";
    home.packages = with pkgs; [
      # TODO: add home packages
    ];
  };
in {
  inherit flake;
}