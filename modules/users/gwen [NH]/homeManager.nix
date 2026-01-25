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
      niri
      kitty
      waybar
      swaync
      swaylock
      swww
      fuzzel
    ];
    home.username = "${username}";
    home.packages = with pkgs; [
      # TODO: add home packages
    ];
  };
}