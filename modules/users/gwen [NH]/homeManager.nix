{
  inputs,
  ...
}:

let
  username = "gwen";

  flake.modules.homeManager."${username}" = {
    pkgs,
    ...
  }:

  {
    imports = with inputs.self.modules.homeManager; [
      # TODO: Define home modules to load here
      # ex: system-cli
    ];
    home.username = "${username}";
    home.packages = with pkgs; [
      # TODO: add home packages
    ];
  };
in
{
  inherit flake;
}