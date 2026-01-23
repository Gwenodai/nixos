{
  inputs,
  ...
}: let
  username = "gwen";
in {

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
}