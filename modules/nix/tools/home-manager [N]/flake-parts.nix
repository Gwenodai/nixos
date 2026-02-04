# Imports Home-Manager as standalone for non-NixOS configurations
{
  inputs,
  ...
}: {
  imports = [
    # https://github.com/nix-community/home-manager
    inputs.home-manager.flakeModules.home-manager
  ];
}