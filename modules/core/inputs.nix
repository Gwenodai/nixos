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
    # flake-aspects.url = "github:vic/flake-aspects/latest";
    # den.url = "github:vic/den/latest";
    den.url = "github:vic/den";
  };

  # Define avialable systems
  systems = [
    # "aarch64-linux"
    "x86_64-linux"
  ];
}