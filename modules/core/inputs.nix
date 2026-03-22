# Declare tools for use in implementing the dendritic pattern
{ inputs, ... }: {
  imports = [
    ( inputs.flake-file.flakeModules.dendritic or {} )
    ( inputs.den.flakeModules.dendritic or {} )
  ];
  
  # Flake inputs
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-file.url = "github:vic/flake-file";
    # Den inputs
    den.url = "github:vic/den/latest";
    flake-aspects.url = "github:vic/flake-aspects/latest";
  };

  # Define avialable systems
  systems = [
    # "aarch64-linux"
    "x86_64-linux"
  ];
}