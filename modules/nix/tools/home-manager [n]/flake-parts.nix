{
  inputs,
  ...
}:

{
  # Imports Home-Manager as standalone for non-NixOS configurations

  imports = [
    # https://github.com/nix-community/home-manager
    inputs.home-manager.flakeModules.home-manager
  ];
}